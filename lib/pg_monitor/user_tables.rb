require_relative "db_connection"

module PgMonitor
  module UserTables
    module_function

    def fetch
      query = <<~SQL
        SELECT 
          relname AS table_name,
          seq_scan,
          last_seq_scan,
          seq_tup_read,
          idx_scan,
          last_idx_scan,
          idx_tup_fetch,
          n_tup_ins,
          n_tup_upd,
          n_tup_del,
          n_live_tup,
          n_dead_tup,
          last_vacuum,
          last_autovacuum,
          last_analyze,
          last_autoanalyze,
          vacuum_count,
          autovacuum_count,
          analyze_count,
          autoanalyze_count
        FROM pg_stat_user_tables
        ORDER BY relname;
      SQL

      result = DBConnection.connection.exec(query)
      result.map { |row| row }
    end
  end
end
