require_relative "db_connection"

module PgMonitor
  module IndexUsage
    module_function

    def fetch
      query = <<~SQL
        SELECT 
          relname AS table_name,
          indexrelname AS index_name,
          idx_scan AS index_scan_count,
          idx_tup_read AS tuples_read,
          idx_tup_fetch AS tuples_fetched,
          last_idx_scan AS last_index_scan,
          pg_size_pretty(pg_relation_size(indexrelid)) AS index_size,
          pg_size_pretty(pg_total_relation_size(indexrelid)) AS total_index_size
        FROM pg_stat_user_indexes
        ORDER BY idx_scan DESC;
      SQL

      result = DBConnection.connection.exec(query)
      result.map { |row| row }
    end
  end
end
