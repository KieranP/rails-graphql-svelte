# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Core
gem 'rails'
gem 'pg'
gem 'puma'
gem 'bootsnap', require: false
gem 'bcrypt'
gem 'redis'

# API
gem 'graphql'
gem 'graphql-batch'
gem 'rack-cors'
gem 'jwt'

# App
gem 'dotenv-rails'
gem 'interaktor'
gem 'pundit'
gem 'sidekiq'

# Misc
gem 'active_model_otp'
gem 'email_validator'

group :development, :test do
  # Testing
  gem 'rspec-rails'

  # Code Quality
  gem 'strong_migrations'
  gem 'prosopite'
  gem 'pg_query'
end

group :development do
  gem 'foreman', require: false
  gem 'annotate'
  gem 'listen'

  # Code Quality
  gem 'database_consistency', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'bundler-audit', require: false
  gem 'brakeman', require: false
  gem 'lefthook', require: false
end

group :test do
  # Testing
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
  gem 'faker'
  gem 'capybara'
  gem 'webdrivers'
  gem 'webmock'

  # Code Quality
  gem 'simplecov'
end
