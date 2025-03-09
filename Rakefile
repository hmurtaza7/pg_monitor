# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

task default: %i[spec standard]

require_relative "lib/pg_monitor/web_app"

desc "Start the PgMonitor web application"
task :server do
  PgMonitorApp.run!
end
