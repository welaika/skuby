require 'webmock/rspec'
require 'vcr'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'skuby'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  # config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end

VCR.configure do |c|
  c.default_cassette_options = { match_requests_on: [:method, :uri, :body] }
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end
