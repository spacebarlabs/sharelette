# frozen_string_literal: true

require "simplecov"

# Configure SimpleCov for code coverage
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"
end

# Basic RSpec configuration
RSpec.configure do |config|
  # Use expect syntax
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Use mocking framework
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Filter lines from Rails gems in backtraces
  config.filter_run_when_matching :focus

  # Disable monkey patching
  config.disable_monkey_patching!

  # Warnings as errors
  config.warnings = true

  # Run specs in random order
  config.order = :random
  Kernel.srand config.seed
end
