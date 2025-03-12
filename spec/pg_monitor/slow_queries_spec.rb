# frozen_string_literal: true

RSpec.describe PgMonitor::SlowQueries do
  it "fetches slow queries" do
    stats = PgMonitor::SlowQueries.fetch(limit: 5)

    expect(stats).to be_an(Array)
    expect(stats.first).to have_key("query")
    expect(stats.first).to have_key("mean_time")
  end
end
