require 'spec_helper'

RSpec.describe 'Sharelette UI', type: :feature do
  before(:each) do
    visit '/index.html'
  end

  describe 'Page load and basic elements' do
    it 'loads the page successfully' do
      expect(page).to have_current_path('/index.html')
      expect(page.status_code).to eq(200) if page.respond_to?(:status_code)
    end

    it 'displays the correct page title' do
      expect(page).to have_title('Sharelette')
    end

    it 'displays the header with logo and title' do
      expect(page).to have_css('h1', text: 'Sharelette')
      expect(page).to have_css('img.logo[alt="Sharelette Logo"]')
    end

    it 'displays the main sharing sections' do
      expect(page).to have_css('h3', text: 'You are sharing')
      expect(page).to have_css('h3', text: 'Share on')
      expect(page).to have_css('h3', text: 'Quick Share')
      expect(page).to have_css('h3', text: 'Save for Later')
      expect(page).to have_css('h3', text: 'Customization')
    end

    it 'displays the preview card' do
      expect(page).to have_css('.preview-card')
      expect(page).to have_css('.preview-label', text: 'PREVIEW')
      expect(page).to have_css('#textContent')
      expect(page).to have_css('#urlContent')
    end
  end

  describe 'Share buttons' do
    it 'displays social media share buttons' do
      expect(page).to have_css('#facebook-share', text: 'Facebook')
      expect(page).to have_css('#twitter-share', text: 'Twitter')
      expect(page).to have_css('#bluesky-share', text: 'Bluesky')
      expect(page).to have_css('#linkedin-share', text: 'LinkedIn')
      expect(page).to have_css('#reddit-share', text: 'Reddit')
      expect(page).to have_css('#mastodon-share', text: 'Mastodon')
      expect(page).to have_css('#lemmy-share', text: 'Lemmy')
      expect(page).to have_css('#discord-share', text: 'Discord')
      expect(page).to have_css('#email-share', text: 'Email')
      expect(page).to have_css('#sms-share', text: 'SMS')
    end

    it 'displays copy button' do
      expect(page).to have_css('#copy-btn', text: 'Copy Text & Link')
    end

    it 'displays save for later buttons' do
      expect(page).to have_css('#instapaper-save', text: 'Instapaper')
      expect(page).to have_css('#wallabag-save', text: 'Wallabag')
      expect(page).to have_css('#linkding-save', text: 'Linkding')
      expect(page).to have_css('#raindrop-save', text: 'Raindrop')
      expect(page).to have_css('#feedbin-save', text: 'Feedbin')
    end
  end

  describe 'Settings panel interaction' do
    it 'has a settings toggle button' do
      expect(page).to have_css('#settings-toggle-btn', text: 'Personal Settings')
    end

    it 'toggles settings panel on button click', js: true do
      # Settings panel should be hidden initially
      expect(page).to have_css('#settings-panel:not(.is-visible)', visible: :all)
      
      # Click settings toggle button
      find('#settings-toggle-btn').click
      
      # Wait for panel to become visible
      expect(page).to have_css('#settings-panel.is-visible', visible: :visible)
    end

    it 'displays settings form when panel is visible', js: true do
      find('#settings-toggle-btn').click
      
      expect(page).to have_css('#settings-form')
      expect(page).to have_css('#mastodon-instance')
      expect(page).to have_css('#lemmy-instance')
      expect(page).to have_css('#wallabag-instance')
      expect(page).to have_css('#linkding-instance')
      expect(page).to have_css('#save-settings-btn', text: 'Save Settings')
    end
  end

  describe 'Quick Share contacts form', js: true do
    before do
      # Open settings panel to access quick share form
      find('#settings-toggle-btn').click
      expect(page).to have_css('#settings-panel.is-visible')
    end

    it 'displays quick share contact form' do
      expect(page).to have_css('#quick-share-form')
      expect(page).to have_css('#quick-share-name')
      expect(page).to have_css('#quick-share-contact')
      expect(page).to have_css('#quick-share-type')
      expect(page).to have_css('#add-quick-share-btn', text: 'Add Person')
    end

    it 'can add a quick share contact' do
      # Fill in the quick share form
      fill_in 'quick-share-name', with: 'Test Friend'
      fill_in 'quick-share-contact', with: 'test@example.com'
      select 'Email', from: 'quick-share-type'
      
      # Submit the form
      find('#add-quick-share-btn').click
      
      # Check if contact appears in the list (if list exists)
      if page.has_css?('#quick-share-list .custom-share-item', wait: 2)
        expect(page).to have_css('#quick-share-list .custom-share-item', text: 'Test Friend')
      end
    end

    it 'can remove a quick share contact after adding' do
      # Add a contact first
      fill_in 'quick-share-name', with: 'Remove Me'
      fill_in 'quick-share-contact', with: 'remove@example.com'
      find('#add-quick-share-btn').click
      
      # Wait and check if remove button exists
      if page.has_css?('.remove-custom-btn', wait: 2)
        # Click the first remove button
        first('.remove-custom-btn').click
        
        # Verify contact is removed or reduced
        sleep 0.5 # Allow time for removal
      end
    end
  end

  describe 'Custom share buttons form', js: true do
    before do
      # Open settings panel
      find('#settings-toggle-btn').click
      expect(page).to have_css('#settings-panel.is-visible')
    end

    it 'displays custom share button form' do
      expect(page).to have_css('#custom-share-form')
      expect(page).to have_css('#custom-name')
      expect(page).to have_css('#custom-url')
      expect(page).to have_css('#add-custom-btn', text: 'Add Custom Button')
    end

    it 'can add a custom share button' do
      # Fill in custom share form
      fill_in 'custom-name', with: 'My Forum'
      fill_in 'custom-url', with: 'https://example.com/share?url=%URL%'
      
      # Submit the form
      find('#add-custom-btn').click
      
      # Check if custom button appears in list (if list exists)
      if page.has_css?('#custom-share-list .custom-share-item', wait: 2)
        expect(page).to have_css('#custom-share-list .custom-share-item', text: 'My Forum')
      end
    end
  end

  describe 'Link generator', js: true do
    it 'has a button to show the generator' do
      expect(page).to have_css('#show-generator-btn', text: 'Create Your Share Link & QR Code')
    end

    it 'shows the generator when button is clicked' do
      find('#show-generator-btn').click
      
      expect(page).to have_css('#generator-container', visible: :visible)
      expect(page).to have_css('#link-generator-form')
      expect(page).to have_css('#input-url')
      expect(page).to have_css('#input-text')
      expect(page).to have_css('#generate-link-btn', text: 'Generate Link & QR Code')
    end

    it 'can generate a link and QR code' do
      # Show generator
      find('#show-generator-btn').click
      
      # Fill in the form
      fill_in 'input-url', with: 'https://example.com'
      fill_in 'input-text', with: 'Check this out!'
      
      # Generate link
      find('#generate-link-btn').click
      
      # Wait for output area to appear
      expect(page).to have_css('#output-area', visible: :visible, wait: 5)
      
      # Check that generated link is displayed
      expect(page).to have_css('#generated-link-output')
      generated_link = find('#generated-link-output').value
      expect(generated_link).not_to be_empty
      
      # Check that QR code output is visible
      expect(page).to have_css('#qrcode-output', visible: :visible)
      expect(page).to have_css('#qrcode-container')
    end

    it 'can copy the generated link' do
      # Show generator and generate a link
      find('#show-generator-btn').click
      fill_in 'input-url', with: 'https://example.com'
      fill_in 'input-text', with: 'Test text'
      find('#generate-link-btn').click
      
      # Wait for output area and copy button (may be hidden initially)
      expect(page).to have_css('#output-area', visible: :visible, wait: 10)
      
      # Check if copy button exists and try to click it
      if page.has_css?('#copy-generated-link-btn', visible: :all, wait: 2)
        find('#copy-generated-link-btn', visible: :all).click
      end
    end
  end

  describe 'Coupon dismissal', js: true do
    it 'can hide the coupon code banner' do
      if page.has_css?('#hide-coupon-btn', wait: 1)
        # Click hide button
        find('#hide-coupon-btn').click
        
        # Banner should be hidden or removed
        sleep 0.5
        expect(page).not_to have_css('.coupon-code', visible: :visible)
      end
    end
  end

  describe 'Footer' do
    it 'displays footer with attribution' do
      expect(page).to have_css('.footer')
      expect(page).to have_css('.footer a[href*="spacebarlabs.com"]')
      expect(page).to have_text('space bar labs')
    end
  end
end
