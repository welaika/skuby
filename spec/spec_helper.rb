require 'coveralls'
Coveralls.wear!

require 'webmock/rspec'
require 'mocha/api'
require 'vcr'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'skuby'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.mock_framework = :mocha
  config.order = 'random'
end

VCR.configure do |c|
  c.default_cassette_options = { match_requests_on: [:method, :uri, :body] }
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end
