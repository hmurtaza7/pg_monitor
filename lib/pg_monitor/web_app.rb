require "sinatra"
require_relative "db_connection"
require_relative "index_usage"
require_relative "slow_queries"
require_relative "user_tables"
require_relative "pg_locks"

class PgMonitorApp < Sinatra::Base
  get "/" do
    @index_usage = PgMonitor::IndexUsage.fetch
    @slow_queries = PgMonitor::SlowQueries.fetch(limit: 10)
    @user_tables = PgMonitor::UserTables.fetch
    @locks = PgMonitor::PGLocks.fetch

    erb :index
  end
end
