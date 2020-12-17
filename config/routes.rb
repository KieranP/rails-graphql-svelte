Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  get "*path", to: 'home#index'
end
