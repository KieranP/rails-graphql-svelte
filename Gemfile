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
gem 'pundit'
gem 'sidekiq'

group :development, :test do
  # Testing
  gem 'rspec-rails'

  # Code Quality
  gem 'prosopite'
end

group :development do
  gem 'foreman', require: false
  gem 'annotate'
  gem 'listen'

  # Code Quality
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
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
