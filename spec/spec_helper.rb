# frozen_string_literal: true

require "pg"
require "pg_monitor"
require "ostruct"

ENV["PG_DATABASE"] = "pg_monitor_test"
ENV["PG_USER"] = "postgres"
ENV["PG_PASSWORD"] = "password"
ENV["PG_HOST"] = "localhost"
ENV["PG_PORT"] = "5432"

# Ensure test DB exists
def setup_test_db
  conn = PgMonitor::DBConnection.connection
  conn.exec("CREATE EXTENSION IF NOT EXISTS pg_stat_statements;") # Enable tracking for slow queries
  conn.exec("CREATE TABLE IF NOT EXISTS test_table (id SERIAL PRIMARY KEY, data TEXT);")
  conn.exec("CREATE INDEX IF NOT EXISTS test_index ON test_table (data);")
end

setup_test_db

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Clear DB connection between tests to avoid leaking doubles
  config.before do
    PgMonitor::DBConnection.clear_connection! if defined?(PgMonitor::DBConnection)
  end
end
