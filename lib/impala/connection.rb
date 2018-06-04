module Impala
  # This object represents a connection to an Impala server. It can be used to
  # perform queries on the database.
  class Connection
    attr_accessor :host, :port

    # Don't instantiate Connections directly; instead, use {Impala.connect}.
    def initialize(host, port, options={})
      @host = host
      @port = port
      @connected = false
      @options = options.dup
      @options[:transport] ||= :buffered
      @loggers = @options.fetch(:loggers, [])
      open
    end

    def inspect
      "#<#{self.class} #{@host}:#{@port}#{open? ? '' : ' (DISCONNECTED)'}>"
    end

    # Open the connection if it's currently closed.
    def open
      return if @connected

      @transport = thrift_transport(host, port)
      @transport.open do |transport|
        enable_keepalive(transport)
      end

      proto = Thrift::BinaryProtocol.new(@transport)
      @service = Protocol::ImpalaService::Client.new(proto)
      @connected = true
    end

    def thrift_transport(server, port)
      socket = thrift_socket(server, port, @options[:timeout])

      case @options[:transport]
      when :buffered
        return Thrift::BufferedTransport.new(socket)
      when :sasl
        opts = parse_sasl_params(@options[:sasl_params])
        mechanism = opts.delete(:mechanism)
        return SASLTransport.new(socket, mechanism, opts)
      else
        raise "Unrecognised transport type '#{@options[:transport]}'"
      end
    end

    def thrift_socket(server, port, timeout)
      socket = Thrift::Socket.new(server, port)
      socket.timeout = timeout
      socket
    end

    # Processes SASL connection params and returns a hash with symbol keys or a nil
    def parse_sasl_params(sasl_params)
      # Symbilize keys in a hash
      if sasl_params.kind_of?(Hash)
        return sasl_params.inject({}) do |memo,(k,v)|
          memo[k.to_sym] = v;
          memo
        end
      end
      return nil
    end

    # Close this connection. It can still be reopened with {#open}.
    def close
      log_debug("Closing #{self}")
      return unless @connected
      log_debug("Closed #{self}")

      @transport.close
      @connected = false
    end

    # Returns true if the connection is currently open.
    def open?
      @connected
    end

    # Refresh the metadata store.
    def refresh
      raise ConnectionError.new("Connection closed") unless open?
      @service.ResetCatalog
    end

    # Perform a query and return all the results. This will
    # load the entire result set into memory, so if you're dealing with lots
    # of rows, {#execute} may work better.
    # @param [String] query the query you want to run
    # @param [Hash] query_options the options to set user and configuration
    #   except for :user, see TImpalaQueryOptions in ImpalaService.thrift
    # @option query_options [String] :user the user runs the query
    # @return [Array<Hash>] an array of hashes, one for each row.
    def query(raw_query, query_options = {})
      execute(raw_query, query_options).fetch_all
    end

    # Perform a query and return a cursor for iterating over the results.
    # @param [String] query the query you want to run
    # @param [Hash] query_options the options to set user and configuration
    #   except for :user, see TImpalaQueryOptions in ImpalaService.thrift
    # @option query_options [String] :user the user runs the query
    # @return [Cursor] a cursor for the result rows
    def execute(raw_query, query_options = {})
      raise ConnectionError.new("Connection closed") unless open?
      handle_proc = query_options.delete(:handle_proc)

      query = sanitize_query(raw_query)
      log_debug(query.slice(0,100))
      query_options = Hash[query_options]
      cursor_options = query_options.delete(:cursor_options)
      handle = send_query(query, query_options)

      handle_proc.call(handle) if handle_proc

      cursor_options = cursor_options ? @options.merge(cursor_options) : @options.dup
      cursor_options[:loggers] = @loggers
      cursor = Cursor.new(handle, @service, cursor_options)
      cursor.wait!
      cursor
    end

    def close_handle(handle)
      log_debug("Closing #{handle}")
      @service.close(handle)
    end

    private

    def sanitize_query(raw_query)
      words = raw_query.split
      raise InvalidQueryError.new("Empty query") if words.empty?

      command = words.first.downcase
      ([command] + words[1..-1]).join(' ')
    end

    def send_query(sanitized_query, query_options)
      query = Protocol::Beeswax::Query.new
      query.query = sanitized_query

      query.hadoop_user = query_options.delete(:user) if query_options[:user]
      query.configuration = query_options.map do |key, value|
        "#{key.upcase}=#{value}"
      end

      @service.query(query)
    end

    def enable_keepalive(transport)
      s = transport.handle
      log_debug("Enabling KEEPALIVE...")
      s.setsockopt(::Socket::SOL_SOCKET, ::Socket::SO_KEEPALIVE, true)

      # Apparently Mac OS X (Darwin) doesn't implement the SOL_TCP options below
      # so we'll hope keep alive works under Mac OS X, but in production
      # we Dockerize Jigsaw, so these options should be available when
      # we're running on Linux
      if defined?(::Socket::SOL_TCP)
        opts = {}

        if defined?(::Socket::TCP_KEEPIDLE)
          opts[::Socket::TCP_KEEPIDLE] = 60
        end

        if defined?(::Socket::TCP_KEEPINTVL)
          opts[::Socket::TCP_KEEPINTVL] = 10
        end

        if defined?(::Socket::TCP_KEEPCNT)
          opts[::Socket::TCP_KEEPCNT] = 5
        end

        log_debug("Also enabling: #{opts.inspect}")
        opts.each do |opt, value|
          s.setsockopt(::Socket::SOL_TCP, opt, value)
        end
      end
    end

    def log_debug(message)
      @loggers.each do |logger|
        logger.debug(message)
      end
    end
  end
end
