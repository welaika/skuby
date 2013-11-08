require 'coveralls'
Coveralls.wear!

require 'webmock/rspec'
require 'vcr'
require 'pry'

require 'skuby'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

Skuby.setup do |config|
  config.method = 'send_sms_classic_report'
  config.username = 'username'
  config.password = 'password'
  config.sender_string = 'company'
end

