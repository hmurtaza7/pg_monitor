# frozen_string_literal: true

RSpec.describe PgMonitor::DBConnection do
  before do
    PgMonitor::DBConnection.clear_connection!
  end

  describe ".connection" do
    context "when Active Record is not present" do
      before do
        allow(PgMonitor::DBConnection).to receive(:active_record_present?).and_return(false)
      end

      it "creates a PG connection using environment variables" do
        connection = double("PG Connection")
        expect(PG).to receive(:connect).with(PgMonitor::DBConnection.connection_params).and_return(connection)

        expect(PgMonitor::DBConnection.connection).to eq(connection)
      end
    end

    context "when Active Record is present" do
      before do
        allow(PgMonitor::DBConnection).to receive(:active_record_present?).and_return(true)

        # Mock ActiveRecord
        # standard:disable Lint/ConstantDefinitionInBlock
        module ActiveRecord
          class Base
            extend RSpec::Mocks::ExampleMethods

            def self.connection
              @connection ||= OpenStruct.new(raw_connection: double("Active Record PG Connection"))
            end
          end
        end
        # standard:enable Lint/ConstantDefinitionInBlock
      end

      after do
        Object.send(:remove_const, :ActiveRecord) if defined?(ActiveRecord)
      end

      it "uses the Active Record database connection" do
        expect(PgMonitor::DBConnection.connection).to eq(ActiveRecord::Base.connection.raw_connection)
      end
    end
  end
end
