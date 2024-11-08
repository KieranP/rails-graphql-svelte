# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  post '/graphql', to: 'graphql#execute'

  mount ActionCable.server, at: '/cable'

  if Rails.env.test?
    # Used to quickly login feature tests
    get '/testing/login', to: 'testing#login'
    get '/testing/logout', to: 'testing#logout'

    get '*path', to: 'testing#index'
    root to: 'testing#index'
  end
end
