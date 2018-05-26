# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'rspec/rails'
require 'simplecov'
require 'capybara/rspec'
require 'supports/factory_bot'
require 'paperclip/matchers'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
SimpleCov.start

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Add support for Paperclip's Shoulda Matchers
  config.include Paperclip::Shoulda::Matchers

  # Clean up file uploads when test suite is finished
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_uploads/"])
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
