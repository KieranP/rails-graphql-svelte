module Types
  class Mutations < Object
    field :create_user, mutation: ::Mutations::User::Create
    field :update_user, mutation: ::Mutations::User::Update
    field :authenticate_user, mutation: ::Mutations::User::Authenticate

    field :create_post, mutation: ::Mutations::Post::Create
    field :update_post, mutation: ::Mutations::Post::Update
    field :destroy_post, mutation: ::Mutations::Post::Destroy
  end
end
