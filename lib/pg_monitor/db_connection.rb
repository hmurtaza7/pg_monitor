require "pg"

module PgMonitor
  class DBConnection
    def self.connection
      if active_record_present?
        ActiveRecord::Base.connection.raw_connection
      else
        @connection ||= PG.connect(connection_params)
      end
    end

    def self.active_record_present?
      defined?(ActiveRecord::Base)
    end

    def self.connection_params
      {
        dbname: ENV.fetch("PG_DATABASE"),
        user: ENV.fetch("PG_USER"),
        password: ENV.fetch("PG_PASSWORD"),
        host: ENV.fetch("PG_HOST"),
        port: ENV.fetch("PG_PORT")
      }
    end

    def self.clear_connection!
      @connection = nil
    end
  end
end
