#
# Autogenerated by Thrift Compiler (0.9.1)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'
require 'beeswax_types'

module Impala
  module Protocol
    module Beeswax
      module BeeswaxService
        class Client
          include ::Thrift::Client

          def query(query)
            send_query(query)
            return recv_query()
          end

          def send_query(query)
            send_message('query', Query_args, :query => query)
          end

          def recv_query()
            result = receive_message(Query_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'query failed: unknown result')
          end

          def executeAndWait(query, clientCtx)
            send_executeAndWait(query, clientCtx)
            return recv_executeAndWait()
          end

          def send_executeAndWait(query, clientCtx)
            send_message('executeAndWait', ExecuteAndWait_args, :query => query, :clientCtx => clientCtx)
          end

          def recv_executeAndWait()
            result = receive_message(ExecuteAndWait_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'executeAndWait failed: unknown result')
          end

          def explain(query)
            send_explain(query)
            return recv_explain()
          end

          def send_explain(query)
            send_message('explain', Explain_args, :query => query)
          end

          def recv_explain()
            result = receive_message(Explain_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'explain failed: unknown result')
          end

          def fetch(query_id, start_over, fetch_size)
            send_fetch(query_id, start_over, fetch_size)
            return recv_fetch()
          end

          def send_fetch(query_id, start_over, fetch_size)
            send_message('fetch', Fetch_args, :query_id => query_id, :start_over => start_over, :fetch_size => fetch_size)
          end

          def recv_fetch()
            result = receive_message(Fetch_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise result.error2 unless result.error2.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'fetch failed: unknown result')
          end

          def get_state(handle)
            send_get_state(handle)
            return recv_get_state()
          end

          def send_get_state(handle)
            send_message('get_state', Get_state_args, :handle => handle)
          end

          def recv_get_state()
            result = receive_message(Get_state_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get_state failed: unknown result')
          end

          def get_results_metadata(handle)
            send_get_results_metadata(handle)
            return recv_get_results_metadata()
          end

          def send_get_results_metadata(handle)
            send_message('get_results_metadata', Get_results_metadata_args, :handle => handle)
          end

          def recv_get_results_metadata()
            result = receive_message(Get_results_metadata_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get_results_metadata failed: unknown result')
          end

          def echo(s)
            send_echo(s)
            return recv_echo()
          end

          def send_echo(s)
            send_message('echo', Echo_args, :s => s)
          end

          def recv_echo()
            result = receive_message(Echo_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'echo failed: unknown result')
          end

          def dump_config()
            send_dump_config()
            return recv_dump_config()
          end

          def send_dump_config()
            send_message('dump_config', Dump_config_args)
          end

          def recv_dump_config()
            result = receive_message(Dump_config_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'dump_config failed: unknown result')
          end

          def get_log(context)
            send_get_log(context)
            return recv_get_log()
          end

          def send_get_log(context)
            send_message('get_log', Get_log_args, :context => context)
          end

          def recv_get_log()
            result = receive_message(Get_log_result)
            return result.success unless result.success.nil?
            raise result.error unless result.error.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get_log failed: unknown result')
          end

          def get_default_configuration(include_hadoop)
            send_get_default_configuration(include_hadoop)
            return recv_get_default_configuration()
          end

          def send_get_default_configuration(include_hadoop)
            send_message('get_default_configuration', Get_default_configuration_args, :include_hadoop => include_hadoop)
          end

          def recv_get_default_configuration()
            result = receive_message(Get_default_configuration_result)
            return result.success unless result.success.nil?
            raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'get_default_configuration failed: unknown result')
          end

          def close(handle)
            send_close(handle)
            recv_close()
          end

          def send_close(handle)
            send_message('close', Close_args, :handle => handle)
          end

          def recv_close()
            result = receive_message(Close_result)
            raise result.error unless result.error.nil?
            raise result.error2 unless result.error2.nil?
            return
          end

          def clean(log_context)
            send_clean(log_context)
            recv_clean()
          end

          def send_clean(log_context)
            send_message('clean', Clean_args, :log_context => log_context)
          end

          def recv_clean()
            result = receive_message(Clean_result)
            return
          end

        end

        class Processor
          include ::Thrift::Processor

          def process_query(seqid, iprot, oprot)
            args = read_args(iprot, Query_args)
            result = Query_result.new()
            begin
              result.success = @handler.query(args.query)
            rescue ::Impala::Protocol::Beeswax::BeeswaxException => error
              result.error = error
            end
            write_result(result, oprot, 'query', seqid)
          end

          def process_executeAndWait(seqid, iprot, oprot)
            args = read_args(iprot, ExecuteAndWait_args)
            result = ExecuteAndWait_result.new()
            begin
              result.success = @handler.executeAndWait(args.query, args.clientCtx)
            rescue ::Impala::Protocol::Beeswax::BeeswaxException => error
              result.error = error
            end
            write_result(result, oprot, 'executeAndWait', seqid)
          end

          def process_explain(seqid, iprot, oprot)
            args = read_args(iprot, Explain_args)
            result = Explain_result.new()
            begin
              result.success = @handler.explain(args.query)
            rescue ::Impala::Protocol::Beeswax::BeeswaxException => error
              result.error = error
            end
            write_result(result, oprot, 'explain', seqid)
          end

          def process_fetch(seqid, iprot, oprot)
            args = read_args(iprot, Fetch_args)
            result = Fetch_result.new()
            begin
              result.success = @handler.fetch(args.query_id, args.start_over, args.fetch_size)
            rescue ::Impala::Protocol::Beeswax::QueryNotFoundException => error
              result.error = error
            rescue ::Impala::Protocol::Beeswax::BeeswaxException => error2
              result.error2 = error2
            end
            write_result(result, oprot, 'fetch', seqid)
          end

          def process_get_state(seqid, iprot, oprot)
            args = read_args(iprot, Get_state_args)
            result = Get_state_result.new()
            begin
              result.success = @handler.get_state(args.handle)
            rescue ::Impala::Protocol::Beeswax::QueryNotFoundException => error
              result.error = error
            end
            write_result(result, oprot, 'get_state', seqid)
          end

          def process_get_results_metadata(seqid, iprot, oprot)
            args = read_args(iprot, Get_results_metadata_args)
            result = Get_results_metadata_result.new()
            begin
              result.success = @handler.get_results_metadata(args.handle)
            rescue ::Impala::Protocol::Beeswax::QueryNotFoundException => error
              result.error = error
            end
            write_result(result, oprot, 'get_results_metadata', seqid)
          end

          def process_echo(seqid, iprot, oprot)
            args = read_args(iprot, Echo_args)
            result = Echo_result.new()
            result.success = @handler.echo(args.s)
            write_result(result, oprot, 'echo', seqid)
          end

          def process_dump_config(seqid, iprot, oprot)
            args = read_args(iprot, Dump_config_args)
            result = Dump_config_result.new()
            result.success = @handler.dump_config()
            write_result(result, oprot, 'dump_config', seqid)
          end

          def process_get_log(seqid, iprot, oprot)
            args = read_args(iprot, Get_log_args)
            result = Get_log_result.new()
            begin
              result.success = @handler.get_log(args.context)
            rescue ::Impala::Protocol::Beeswax::QueryNotFoundException => error
              result.error = error
            end
            write_result(result, oprot, 'get_log', seqid)
          end

          def process_get_default_configuration(seqid, iprot, oprot)
            args = read_args(iprot, Get_default_configuration_args)
            result = Get_default_configuration_result.new()
            result.success = @handler.get_default_configuration(args.include_hadoop)
            write_result(result, oprot, 'get_default_configuration', seqid)
          end

          def process_close(seqid, iprot, oprot)
            args = read_args(iprot, Close_args)
            result = Close_result.new()
            begin
              @handler.close(args.handle)
            rescue ::Impala::Protocol::Beeswax::QueryNotFoundException => error
              result.error = error
            rescue ::Impala::Protocol::Beeswax::BeeswaxException => error2
              result.error2 = error2
            end
            write_result(result, oprot, 'close', seqid)
          end

          def process_clean(seqid, iprot, oprot)
            args = read_args(iprot, Clean_args)
            result = Clean_result.new()
            @handler.clean(args.log_context)
            write_result(result, oprot, 'clean', seqid)
          end

        end

        # HELPER FUNCTIONS AND STRUCTURES

        class Query_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUERY = 1

          FIELDS = {
            QUERY => {:type => ::Thrift::Types::STRUCT, :name => 'query', :class => ::Impala::Protocol::Beeswax::Query}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Query_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Impala::Protocol::Beeswax::QueryHandle},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::BeeswaxException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class ExecuteAndWait_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUERY = 1
          CLIENTCTX = 2

          FIELDS = {
            QUERY => {:type => ::Thrift::Types::STRUCT, :name => 'query', :class => ::Impala::Protocol::Beeswax::Query},
            CLIENTCTX => {:type => ::Thrift::Types::STRING, :name => 'clientCtx'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class ExecuteAndWait_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Impala::Protocol::Beeswax::QueryHandle},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::BeeswaxException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Explain_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUERY = 1

          FIELDS = {
            QUERY => {:type => ::Thrift::Types::STRUCT, :name => 'query', :class => ::Impala::Protocol::Beeswax::Query}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Explain_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Impala::Protocol::Beeswax::QueryExplanation},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::BeeswaxException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Fetch_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          QUERY_ID = 1
          START_OVER = 2
          FETCH_SIZE = 3

          FIELDS = {
            QUERY_ID => {:type => ::Thrift::Types::STRUCT, :name => 'query_id', :class => ::Impala::Protocol::Beeswax::QueryHandle},
            START_OVER => {:type => ::Thrift::Types::BOOL, :name => 'start_over'},
            FETCH_SIZE => {:type => ::Thrift::Types::I32, :name => 'fetch_size', :default => -1}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Fetch_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1
          ERROR2 = 2

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Impala::Protocol::Beeswax::Results},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::QueryNotFoundException},
            ERROR2 => {:type => ::Thrift::Types::STRUCT, :name => 'error2', :class => ::Impala::Protocol::Beeswax::BeeswaxException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_state_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          HANDLE = 1

          FIELDS = {
            HANDLE => {:type => ::Thrift::Types::STRUCT, :name => 'handle', :class => ::Impala::Protocol::Beeswax::QueryHandle}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_state_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::I32, :name => 'success', :enum_class => ::Impala::Protocol::Beeswax::QueryState},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::QueryNotFoundException}
          }

          def struct_fields; FIELDS; end

          def validate
            unless @success.nil? || ::Impala::Protocol::Beeswax::QueryState::VALID_VALUES.include?(@success)
              raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Invalid value of field success!')
            end
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_results_metadata_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          HANDLE = 1

          FIELDS = {
            HANDLE => {:type => ::Thrift::Types::STRUCT, :name => 'handle', :class => ::Impala::Protocol::Beeswax::QueryHandle}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_results_metadata_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::Impala::Protocol::Beeswax::ResultsMetadata},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::QueryNotFoundException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Echo_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          S = 1

          FIELDS = {
            S => {:type => ::Thrift::Types::STRING, :name => 's'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Echo_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Dump_config_args
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Dump_config_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_log_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          CONTEXT = 1

          FIELDS = {
            CONTEXT => {:type => ::Thrift::Types::STRING, :name => 'context'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_log_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0
          ERROR = 1

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::STRING, :name => 'success'},
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::QueryNotFoundException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_default_configuration_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          INCLUDE_HADOOP = 1

          FIELDS = {
            INCLUDE_HADOOP => {:type => ::Thrift::Types::BOOL, :name => 'include_hadoop'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Get_default_configuration_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          SUCCESS = 0

          FIELDS = {
            SUCCESS => {:type => ::Thrift::Types::LIST, :name => 'success', :element => {:type => ::Thrift::Types::STRUCT, :class => ::Impala::Protocol::Beeswax::ConfigVariable}}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Close_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          HANDLE = 1

          FIELDS = {
            HANDLE => {:type => ::Thrift::Types::STRUCT, :name => 'handle', :class => ::Impala::Protocol::Beeswax::QueryHandle}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Close_result
          include ::Thrift::Struct, ::Thrift::Struct_Union
          ERROR = 1
          ERROR2 = 2

          FIELDS = {
            ERROR => {:type => ::Thrift::Types::STRUCT, :name => 'error', :class => ::Impala::Protocol::Beeswax::QueryNotFoundException},
            ERROR2 => {:type => ::Thrift::Types::STRUCT, :name => 'error2', :class => ::Impala::Protocol::Beeswax::BeeswaxException}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Clean_args
          include ::Thrift::Struct, ::Thrift::Struct_Union
          LOG_CONTEXT = 1

          FIELDS = {
            LOG_CONTEXT => {:type => ::Thrift::Types::STRING, :name => 'log_context'}
          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

        class Clean_result
          include ::Thrift::Struct, ::Thrift::Struct_Union

          FIELDS = {

          }

          def struct_fields; FIELDS; end

          def validate
          end

          ::Thrift::Struct.generate_accessors self
        end

      end

    end
  end
end
