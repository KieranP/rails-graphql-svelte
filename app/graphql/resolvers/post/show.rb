module Resolvers::Post
  class Show < Types::Resolver
    graphql_name "PostShow"

    type Objects::Post, null: false

    argument :id, ID, required: true

    def authorized?(**args)
      raise not_found_error('Post Not Found') unless find_post(**args)
      raise forbidden_error unless policy.show?
      true
    end

    def resolve(**args)
      @post
    end

    private

    def find_post(**args)
      @post ||= Post.find_by_id(args[:id])
    end

    def policy
      PostPolicy.new(current_user, @post)
    end
  end
end
