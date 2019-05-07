module Multidb
  module LogSubscriber
    def debug(msg)
      if name = Multidb.balancer.current_connection_name
        db = color("[DB: #{name}]", ActiveSupport::LogSubscriber::GREEN, true)
        super(db + msg)
      else
        super(msg)
      end
    end
  end
end

ActiveRecord::LogSubscriber.prepend(Multidb::LogSubscriber)
