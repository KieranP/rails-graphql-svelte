# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'

Capybara.server = :puma
Capybara.server_host = 'localhost'
Capybara.server_port = 3030

if ENV['HEADLESS'] == 'false'
  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
else
  Capybara.default_driver = :selenium_chrome_headless
  Capybara.javascript_driver = :selenium_chrome_headless
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
  # config.filter_gems_from_backtrace("gem name")

  config.include FactoryBot::Syntax::Methods
  config.include AuthenticationHelpers

  config.before(:suite) do
    unless ENV['BUILD_FRONTEND'] == 'false'
      puts 'Bulding Route File...'
      puts `yarn routify -b`
      puts ''

      puts 'Building Frontend App...'
      puts `yarn snowpack build --polyfill-node`
      puts ''
    end
  end
end
