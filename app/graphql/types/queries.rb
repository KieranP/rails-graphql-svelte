# frozen_string_literal: true

module Types
  class Queries < Objects::Base
    field :find_user, resolver: ::Resolvers::User::Show

    field :all_posts, resolver: ::Resolvers::Post::Index, max_page_size: 20
    field :find_post, resolver: ::Resolvers::Post::Show
  end
end
