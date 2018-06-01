$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))
require 'logger'
require 'sequel'

gem 'minitest'
require 'minitest/autorun'
require 'minitest/hooks/default'
require 'minitest/shared_description'

Sequel::Model.cache_associations = false if ENV['SEQUEL_NO_CACHE_ASSOCIATIONS']
Sequel::Model.cache_anonymous_models = false

unless defined?(DB)
  DB = Sequel.connect(ENV['IMPALA_URL'] || 'jdbc:hive2://localhost:21050/;auth=noSasl')
end
