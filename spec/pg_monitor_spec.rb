# frozen_string_literal: true

RSpec.describe PgMonitor do
  it "has a version number" do
    expect(PgMonitor::VERSION).not_to be nil
  end
end

RSpec.describe PgMonitor::IndexUsage do
  it "fetches index usage statistics" do
    stats = PgMonitor::IndexUsage.fetch

    expect(stats).to be_an(Array)
    expect(stats.first).to have_key("table_name")
    expect(stats.first).to have_key("index_name")
  end
end

RSpec.describe PgMonitor::SlowQueries do
  it "fetches slow queries" do
    stats = PgMonitor::SlowQueries.fetch(limit: 5)

    expect(stats).to be_an(Array)
    expect(stats.first).to have_key("query")
    expect(stats.first).to have_key("mean_time")
  end
end
