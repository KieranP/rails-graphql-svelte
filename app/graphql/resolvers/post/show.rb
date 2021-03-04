# frozen_string_literal: true

module Resolvers
  module Post
    class Show < Types::Resolver
      graphql_name 'PostShow'

      type Objects::Post, null: false

      argument :uuid, ID, required: true

      def authorized?(**args)
        raise not_found_error('Post Not Found') unless post(**args)
        raise forbidden_error unless policy.show?

        true
      end

      def resolve(**_args)
        @post
      end

      private

      def post(**args)
        @post ||= ::Post.find_by_uuid(args[:uuid])
      end

      def policy
        PostPolicy.new(current_user, @post)
      end
    end
  end
end
