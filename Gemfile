source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Core
gem 'rails'
gem 'sqlite3'
gem 'puma'
gem 'bootsnap', require: false
gem 'rack-cors'
gem 'dotenv-rails'

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
  gem 'factory_bot_rails'
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen'
  gem 'annotate'
end
