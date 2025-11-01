# Running tests locally

1. Install Ruby 3.3.10 (or a compatible Ruby). Using a version manager (rbenv, rvm, asdf) is recommended.
2. Install bundler if you don't have it:
   gem install bundler
3. Install dependencies:
   bundle install
4. Run the test suite (starts a tiny static server and runs system tests):
   bundle exec rspec

CI

A GitHub Actions workflow (.github/workflows/ci.yml) runs RSpec system tests on Ruby 3.3.10. Tests use Capybara + Ferrum (headless Chromium) and start a small WEBrick server to serve the repository root so ./index.html is available at http://localhost:4000/index.html

