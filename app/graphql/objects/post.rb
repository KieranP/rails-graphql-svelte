# frozen_string_literal: true

module Objects
  class Post < Objects::Base
    field :uuid, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    association :user, Objects::User, null: false
  end
end
