require 'socket'

module Thrift
  module KeepAlive
    # We'll override #open so that once the socket is opened
    # we enable keepalive on it
    #
    # Many queries are going to take a long time (10s of minutes) to complete
    # and we don't want the connection to close while we wait for the
    # query to return.
    #
    # Unfortunately, Thrift doesn't supply an easy way to get to the
    # socket that it opens to communicate with Impala.
    #
    # I figured that while I was in here, monkey-patching a way to get
    # to the socket, I might as well just enable keepalive here
    # instead.
    def open
      super
      s = @transport.handle
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

        opts.each do |opt, value|
          s.setsockopt(::Socket::SOL_TCP, opt, value)
        end
      end
    end
  end

  class BufferedTransport
    prepend KeepAlive
  end

  class ImpalaSaslClientTransport
    prepend KeepAlive
  end
end
