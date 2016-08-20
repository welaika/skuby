# frozen_string_literal: true
require 'spec_helper'

describe Skuby::Report do
  before do
    Skuby.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.sender_string = 'company'
    end
    Time.zone = 'Europe/Rome'
  end

  it 'should parses skebby response with errors' do
    params =
      YAML.load(
        File.open(
          fixture_for_skebby_report('error.yaml')
        )
      )
    report = Skuby::Report.new(params)

    report.success?.must_equal false
    report.error_code.must_equal 502
    report.error_message.wont_be_empty
    report.message_id.must_equal 333
    report.dispatch_id.must_equal '444'
    report.delivered_at.must_equal Time.new(
      2005, 8, 15, 15, 51, 1, '+00:00'
    ).in_time_zone
    report.skebby_at.must_equal Time.new(
      2005, 8, 15, 15, 52, 1, '+00:00'
    ).in_time_zone
  end

  it 'should parses skebby response with errors' do
    params =
      YAML.load(
        File.open(
          fixture_for_skebby_report('delivered.yaml')
        )
      )
    report = Skuby::Report.new(params)

    report.success?.must_equal true
    report.message_id.must_equal 777
    report.dispatch_id.must_equal '666'
    report.recipient.must_equal '393471234567'
    report.delivered_at.must_equal Time.new(
      2012, 2, 19, 17, 51, 1, '+00:00'
    ).in_time_zone
  end

  def fixture_for_skebby_report(name)
    File.join(File.dirname(__FILE__), 'fixtures', 'skebby_report', name)
  end
end
