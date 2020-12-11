module Objects
  class Post < Types::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    field :user, Objects::User, null: false
  end
end
