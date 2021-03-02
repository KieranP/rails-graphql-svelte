# frozen_string_literal: true

module Resolvers
  module Post
    class Index < Types::Resolver
      graphql_name 'PostIndex'

      type Objects::Post.connection_type, null: false

      def authorized?(**_args)
        raise forbidden_error unless policy.index?

        true
      end

      def resolve(**_args)
        ::Post.all
      end

      private

      def policy
        PostPolicy.new(current_user, nil)
      end
    end
  end
end
