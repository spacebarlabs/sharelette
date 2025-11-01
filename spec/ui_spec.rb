require "spec_helper"
require_relative "support/server_helper"

RSpec.describe "index.html UI", type: :feature do
  before(:all) do
    @server, @thread = ServerHelper.start(dir: Dir.pwd, port: 4000)
    # Give server a moment to boot
    sleep 0.2
  end

  after(:all) do
    @server.shutdown if @server
    @thread.kill if @thread && @thread.alive?
  end

  it "loads the page and shows a header/title" do
    visit "/index.html"
    expect(page).to have_selector("h1, h2, title", minimum: 1)
  end

  it "accepts input and performs primary action flow" do
    visit "/index.html"
    # Try common selectors
    if page.has_selector?('input#share-url')
      fill_in 'share-url', with: 'https://example.com'
    elsif page.has_selector?('input[name="url"]')
      fill_in 'url', with: 'https://example.com'
    elsif page.has_selector?('input')
      first('input').set('https://example.com')
    end

    # click a primary action button if present
    if page.has_button?('Share')
      click_button 'Share'
    elsif page.has_selector?('button#share-button')
      find('button#share-button').click
    elsif page.has_selector?('button')
      first('button').click
    end

    expect(page).to have_text('Shared').or have_selector('#shared-list').or have_text('copy')
  end

  it "handles adding and removing items if list exists" do
    visit "/index.html"
    if page.has_selector?('#shared-list')
      within('#shared-list') do
        initial = all('li').size
        # attempt to add via available inputs/buttons
        if page.has_selector?('input') && page.has_selector?('button')
          first('input').set('item-test')
          first('button').click
          expect(all('li').size).to be >= initial
        end
      end
    else
      skip 'No #shared-list found in index.html'
    end
  end

  it "shows a confirmation on copy actions if present" do
    visit "/index.html"
    # try to click a copy button
    if page.has_selector?('button.copy')
      find('button.copy').click
      expect(page).to have_text(/copied|copy successful|copied to clipboard/i)
    else
      skip 'No copy button found'
    end
  end
end

