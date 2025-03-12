# frozen_string_literal: true

RSpec.describe PgMonitor::PGLocks do
  it "fetches lock statistics" do
    stats = PgMonitor::PGLocks.fetch

    expect(stats).to be_an(Array)
    expect(stats.first).to have_key("locktype")
    expect(stats.first).to have_key("mode")
  end
end
