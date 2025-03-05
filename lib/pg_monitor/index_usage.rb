require_relative "db_connection"

module PgMonitor
  class IndexUsage
    def fetch
      query = <<~SQL
        SELECT 
          pg_class.relname AS table_name,
          indexrelname AS index_name,
          idx_scan AS index_scan_count,
          idx_tup_read AS tuples_read,
          idx_tup_fetch AS tuples_fetched
        FROM pg_stat_all_indexes
        JOIN pg_class ON pg_stat_all_indexes.relid = pg_class.oid
        ORDER BY idx_scan DESC;
      SQL

      result = DBConnection.connection.exec(query)
      result.map { |row| row }
    end
  end
end
