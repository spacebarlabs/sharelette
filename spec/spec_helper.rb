require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
  add_filter '/vendor/'
end

require 'capybara/rspec'
require_relative 'support/server_helper'
require_relative 'support/capybara'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  Kernel.srand config.seed

  # Start the WEBrick server before running tests
  config.before(:suite) do
    ServerHelper.start
  end

  # Stop the WEBrick server after all tests
  config.after(:suite) do
    ServerHelper.stop
  end
end
