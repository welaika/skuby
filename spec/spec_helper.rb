# frozen_string_literal: true
require 'minitest/reporters'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'coveralls'
require 'simplecov'

require_relative '../lib/skuby'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start do
  add_filter 'spec'
end
Minitest::Reporters.use!

VCR.configure do |config|
  config.default_cassette_options = {
    match_requests_on: [:method, :uri]
  }
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end
