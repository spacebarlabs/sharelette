# Testing Sharelette

This repository includes RSpec system tests that verify the UI functionality of `index.html`.

## Prerequisites

- Ruby 3.3.10 (or 3.3.x)
- Bundler
- Chromium (for headless browser testing via Cuprite)

## Running Tests Locally

1. **Install Ruby dependencies:**

   ```bash
   bundle install
   ```

2. **Run the test suite:**

   ```bash
   bundle exec rspec
   ```

   This will:
   - Start a WEBrick server on port 4000 serving the repository root
   - Run all system tests using Cuprite (Capybara driver for Ferrum/headless Chromium)
   - Generate a code coverage report in the `coverage/` directory

3. **View coverage report:**

   Open `coverage/index.html` in your browser to see detailed code coverage metrics.

## Test Structure

- **spec/spec_helper.rb** - Main RSpec configuration with SimpleCov setup
- **spec/support/server_helper.rb** - WEBrick static file server helper
- **spec/support/capybara.rb** - Capybara and Cuprite driver configuration
- **spec/ui_spec.rb** - System tests for index.html UI

## What's Tested

The test suite covers:
- Page load and basic elements (title, headers, logo)
- All share buttons (social media, email, SMS)
- Save for later buttons
- Settings panel interaction
- Quick Share contact form (add/remove)
- Custom share button form
- Link and QR code generator
- Coupon dismissal functionality
- Footer display

## Continuous Integration

Tests run automatically on GitHub Actions for:
- All pushes to `main` and `add/ci-rspec` branches
- All pull requests to `main`

The CI workflow:
- Uses Ruby 3.3.10
- Installs Chromium and required system dependencies
- Runs the full test suite
- Uploads coverage reports as artifacts

## Troubleshooting

If tests fail locally:

1. **Port 4000 already in use:**
   - Stop any process using port 4000: `lsof -ti:4000 | xargs kill -9`

2. **Chromium not found:**
   - Install Chromium: `sudo apt-get install chromium-browser` (Linux)
   - Or install Chrome/Chromium for your platform

3. **Bundle install fails:**
   - Ensure you have Ruby 3.3.x installed: `ruby -v`
   - Try: `gem install bundler && bundle install`

## Technology Stack

- **RSpec** (~3.12) - Testing framework
- **SimpleCov** (~0.21) - Code coverage
- **Capybara** (~3.40) - Web application testing DSL
- **Cuprite** (~0.15) - Capybara driver for Ferrum (headless Chrome)
- **WEBrick** (~1.8) - Ruby web server for serving static files
