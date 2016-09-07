require 'yaml'

RSpec.describe Skuby::Report do
  let(:report) { Skuby::Report.new(params) }

  context "with errors" do
    let(:params) { YAML.load(File.open(fixture_for_skebby_report('error.yaml'))) }

    it "parses skebby response" do
      expect(report.success?).to be(false)
      expect(report.error_code).to eq(502)
      expect(report.error_message).to be_present
      expect(report.message_id).to eq('333')
      expect(report.dispatch_id).to eq('444')
      expect(report.delivered_at).to eq(Time.new(2005, 8, 15, 15, 51, 1, "+00:00"))
    end
  end

  context "without errors" do
    let(:params) { YAML.load(File.open(fixture_for_skebby_report('delivered.yaml'))) }

    it "parses skebby response" do
      expect(report.success?).to be(true)
      expect(report.message_id).to eq('777')
      expect(report.dispatch_id).to eq('666')
      expect(report.delivered_at).to eq(Time.new(2012, 2, 19, 17, 51, 1, "+00:00"))
    end
  end

  def fixture_for_skebby_report(name)
    File.join(File.dirname(__FILE__), 'fixtures', 'skebby_report', name)
  end
end
