# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'

Capybara.server = :puma
Capybara.server_host = 'localhost'
Capybara.server_port = 3030

if ENV.fetch('HEADLESS', nil) == 'false'
  Capybara.default_driver = :selenium_chrome
  Capybara.javascript_driver = :selenium_chrome
else
  Capybara.default_driver = :selenium_chrome_headless
  Capybara.javascript_driver = :selenium_chrome_headless
end
