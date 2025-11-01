require 'capybara/rspec'
require 'capybara/cuprite'

Capybara.register_driver :cuprite do |app|
  Capybara::Cuprite::Driver.new(app, {
    headless: true,
    browser_options: {
      'no-sandbox': nil,
      'disable-gpu': nil,
      'disable-dev-shm-usage': nil
    },
    timeout: 30
  })
end

Capybara.configure do |config|
  config.default_driver = :cuprite
  config.javascript_driver = :cuprite
  config.app_host = 'http://localhost:4000'
  config.default_max_wait_time = 10
end
