require "capybara/rspec"
require "ferrum"

Capybara.register_driver :ferrum do |app|
  Capybara::Ferrum::Driver.new(app, headless: true)
end
Capybara.default_driver = :ferrum
Capybara.server = :webrick
Capybara.app_host = "http://localhost:4000"
Capybara.default_max_wait_time = 5

