require "pg"

module PgMonitor
  class DBConnection
    def self.connection
      @connection ||= PG.connect(
        dbname: ENV.fetch("PG_DATABASE", "pg_monitor_test"),
        user: ENV.fetch("PG_USER", "postgres"),
        password: ENV.fetch("PG_PASSWORD", "password"),
        host: ENV.fetch("PG_HOST", "localhost"),
        port: ENV.fetch("PG_PORT", "5432")
      )
    end
  end
end
