require "sinatra"
require_relative "db_connection"
require_relative "index_usage"
require_relative "slow_queries"

class PgMonitorApp < Sinatra::Base
  get "/" do
    @index_usage = PgMonitor::IndexUsage.fetch
    @slow_queries = PgMonitor::SlowQueries.fetch(limit: 10)
    erb :index
  end
end
