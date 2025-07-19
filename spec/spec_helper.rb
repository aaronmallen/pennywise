# frozen_string_literal: true

require "simplecov"

SimpleCov.start do
  enable_coverage :branch
  track_files File.expand_path("../**/*.rb", File.dirname(__FILE__))
  add_filter "/config/"
  add_filter "/spec"
end

ENV["HANAMI_ENV"] ||= "test"
require "hanami/prepare"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |expectations| expectations.include_chain_clauses_in_custom_matcher_descriptions = true }
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "log/spec_examples.log"
  config.default_formatter = "doc" if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each { |file| require file }
