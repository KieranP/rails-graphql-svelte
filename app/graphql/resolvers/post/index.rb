module Resolvers::Post
  class Index < Types::Resolver
    graphql_name "PostIndex"

    type Objects::Post.connection_type, null: false

    def authorized?(**args)
      raise forbidden_error unless policy.index?
      true
    end

    def resolve(**args)
      Post.all
    end

    private

    def policy
      PostPolicy.new(current_user, nil)
    end
  end
end
