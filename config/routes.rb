# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  mount ActionCable.server, at: '/cable'

  if Rails.env.test?
    # Used to quickly login feature tests
    get '/testing/login', to: 'testing#login'
    get '/testing/logout', to: 'testing#logout'
  end

  get '*path', to: 'home#index'
  root to: 'home#index'
end
