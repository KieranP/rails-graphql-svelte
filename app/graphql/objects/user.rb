module Objects
  class User < Types::Object
    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    association :posts, [Objects::Post], null: false
  end
end
