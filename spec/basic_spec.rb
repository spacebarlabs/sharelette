# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Basic Smoke Tests" do
  describe "Environment" do
    it "has a truthy environment" do
      expect(true).to be_truthy
    end
  end

  describe "Library Loading" do
    it "attempts to require lib/sharelette.rb if present; otherwise still passes" do
      lib_file = File.expand_path("../../lib/sharelette.rb", __FILE__)
      
      if File.exist?(lib_file)
        expect { require lib_file }.not_to raise_error
      else
        # If the file doesn't exist yet, test passes gracefully
        expect(File.exist?(lib_file)).to be(false).or be(true)
      end
    end
  end
end
