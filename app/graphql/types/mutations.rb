# frozen_string_literal: true

module Types
  class Mutations < Objects::Base
    field :create_user, mutation: ::Mutations::User::Create
    field :update_user, mutation: ::Mutations::User::Update
    field :login_user, mutation: ::Mutations::User::Login
    field :logout_user, mutation: ::Mutations::User::Logout
    field :forgot_password, mutation: ::Mutations::User::ForgotPassword
    field :reset_password, mutation: ::Mutations::User::ResetPassword

    field :create_post, mutation: ::Mutations::Post::Create
    field :update_post, mutation: ::Mutations::Post::Update
    field :destroy_post, mutation: ::Mutations::Post::Destroy
  end
end
