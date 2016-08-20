# frozen_string_literal: true
require 'coveralls'
require 'simplecov'

SimpleCov.formatters = [
  Coveralls::SimpleCov::Formatter,
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start do
  add_filter '/spec/'
  command_name 'test:minitest'
end

require 'minitest/reporters'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'coveralls'
require 'simplecov'

require_relative '../lib/skuby'

Minitest::Reporters.use!

VCR.configure do |config|
  config.default_cassette_options = {
    match_requests_on: [:method, :uri]
  }
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end
