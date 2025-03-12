# frozen_string_literal: true

require_relative "pg_monitor/version"

require_relative "pg_monitor/db_connection"
require_relative "pg_monitor/index_usage"
require_relative "pg_monitor/slow_queries"
require_relative "pg_monitor/user_tables"
require_relative "pg_monitor/pg_locks"

module PgMonitor
end
