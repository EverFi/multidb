require 'active_record/base'

module Multidb
  module ModelExtensions
    def establish_connection(spec = ENV["DATABASE_URL"])
      super(spec)
      Multidb.init(connection_pool.spec.config)
    end

    def connection
      Multidb.balancer.current_connection
    rescue Multidb::NotInitializedError
      super
    end
  end
end

ActiveRecord::Base.singleton_class.prepend(Multidb::ModelExtensions)
