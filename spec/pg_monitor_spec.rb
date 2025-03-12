# frozen_string_literal: true

RSpec.describe PgMonitor do
  it "has a version number" do
    expect(PgMonitor::VERSION).not_to be nil
  end
end
