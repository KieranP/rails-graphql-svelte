# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Core
gem 'rails'
gem 'pg'
gem 'puma'
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'dotenv-rails'
gem 'redis'

# API
gem 'graphql'
gem 'graphql-batch'
gem 'bcrypt'
gem 'jwt'

# App
gem 'pundit'
gem 'kaminari'
gem 'sidekiq'

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'webdrivers'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
  gem 'rubocop-rails', require: false
end

group :development do
  gem 'listen'
  gem 'annotate'
end
