module Types
  class Queries < Object
    field :find_user, resolver: ::Resolvers::User::Show

    field :all_posts, resolver: ::Resolvers::Post::Index
    field :find_post, resolver: ::Resolvers::Post::Show
  end
end
