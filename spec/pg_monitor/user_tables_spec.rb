# frozen_string_literal: true

RSpec.describe PgMonitor::UserTables do
  it "fetches user table statistics" do
    stats = PgMonitor::UserTables.fetch

    expect(stats).to be_an(Array)
    expect(stats.first).to have_key("table_name")
    expect(stats.first).to have_key("seq_scan")
  end
end
