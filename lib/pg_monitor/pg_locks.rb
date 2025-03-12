require_relative "db_connection"

module PgMonitor
  module PGLocks
    module_function

    def fetch
      query = <<~SQL
        SELECT 
          locktype,
          database,
          relation,
          page,
          tuple,
          virtualxid,
          transactionid,
          classid,
          objid,
          objsubid,
          virtualtransaction,
          pid,
          mode,
          granted,
          fastpath,
          waitstart
        FROM pg_locks;
      SQL

      result = DBConnection.connection.exec(query)
      result.map { |row| row }
    end
  end
end
