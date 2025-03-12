# frozen_string_literal: true

RSpec.describe PgMonitor::IndexUsage do
  it "fetches index usage statistics" do
    stats = PgMonitor::IndexUsage.fetch

    expect(stats).to be_an(Array)
    expect(stats.first).to have_key("table_name")
    expect(stats.first).to have_key("index_name")
  end
end
