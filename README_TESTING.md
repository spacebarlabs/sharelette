# Testing Documentation

## Running Tests Locally

This repository uses RSpec for testing with SimpleCov for code coverage.

### Prerequisites

- Ruby 3.3.10 (recommended)
- Bundler

### Setup

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Run the test suite:
   ```bash
   bundle exec rspec
   ```

3. View code coverage:
   - After running tests, open `coverage/index.html` in your browser
   - Coverage reports are generated automatically with each test run

### Test Structure

- **spec/spec_helper.rb**: RSpec and SimpleCov configuration
- **spec/basic_spec.rb**: Lightweight smoke tests that verify the environment and check for lib/sharelette.rb

The tests are intentionally minimal and safe - they will pass even if `lib/sharelette.rb` doesn't exist yet. This allows the CI pipeline to run successfully while the codebase is being developed.

## Continuous Integration (CI)

The repository uses GitHub Actions for automated testing.

### CI Workflow

The CI workflow (`.github/workflows/ci.yml`) automatically runs when:
- Code is pushed to `main`, `master`, or `add/ci-rspec` branches
- Pull requests are opened targeting these branches

### CI Process

1. **Environment Setup**: Uses Ruby 3.3.10 on Ubuntu
2. **Dependency Installation**: Installs gems via Bundler
3. **Test Execution**: Runs the full RSpec test suite
4. **Coverage Upload**: Uploads code coverage reports as artifacts (always available, even if tests fail)

### Viewing CI Results

- Check the "Actions" tab in GitHub to see workflow runs
- Coverage reports are available as downloadable artifacts from each workflow run
- Test results are displayed in the workflow logs with documentation format

## Adding More Tests

As the codebase evolves, you can add more focused specs:

1. Create new spec files in the `spec/` directory
2. Follow the naming convention: `*_spec.rb`
3. Tests will automatically be discovered and run by RSpec

For more information on RSpec, visit: https://rspec.info/
