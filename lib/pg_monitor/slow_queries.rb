require_relative "db_connection"

module PgMonitor
  module SlowQueries
    module_function

    def fetch(limit: 10)
      query = <<~SQL
        SELECT 
          query, 
          calls, 
          total_exec_time AS total_time,
          mean_exec_time AS mean_time,
          max_exec_time AS max_time
        FROM pg_stat_statements
        ORDER BY mean_exec_time DESC
        LIMIT $1;
      SQL

      result = DBConnection.connection.exec_params(query, [limit])
      result.map { |row| row }
    end
  end
end
