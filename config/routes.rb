Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'
  mount ActionCable.server, at: '/cable'
  get '*path', to: 'home#index'
end
