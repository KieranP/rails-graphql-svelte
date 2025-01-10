# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Core
gem 'rails'
gem 'pg'
gem 'puma'
gem 'bootsnap', require: false
gem 'bcrypt'

# API
gem 'graphql'
gem 'graphql-batch'
gem 'rack-cors'
gem 'jwt'

# App
gem 'dotenv-rails'
gem 'interaktor'
gem 'ostruct'
gem 'pundit'
gem 'solid_cache'
gem 'solid_queue'
gem 'solid_cable'

# Deployment
gem 'kamal', require: false
gem 'thruster', require: false

# Misc
gem 'active_model_otp'
gem 'email_validator'

group :development, :test do
  gem 'debug'

  # Testing
  gem 'rspec-rails'

  # Code Quality
  gem 'strong_migrations'
  gem 'prosopite'
  gem 'pg_query'
end

group :development do
  gem 'foreman', require: false
  gem 'web-console'
  gem 'annotaterb'
  gem 'listen'
  gem 'prism'

  # Code Quality
  gem 'database_consistency', require: false
  gem 'rails_best_practices', require: false
  gem 'rubocop-shopify', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-obsession', require: false
  gem 'rubocop-thread_safety', require: false
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false
  gem 'lefthook', require: false
  gem 'fasterer', require: false
end

group :test do
  # Testing
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
  gem 'faker'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webmock'

  # Code Quality
  gem 'simplecov'
end
