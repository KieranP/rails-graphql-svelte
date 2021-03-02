# frozen_string_literal: true

module Mutations
  module Post
    class Destroy < Types::Mutation
      graphql_name 'PostDestroy'

      argument :id, ID, required: true

      field :post, Objects::Post, null: true

      def authorized?(**args)
        raise unauthorised_error unless logged_in?
        raise not_found_error('Post Not Found') unless post(**args)
        raise forbidden_error unless policy.destroy?

        true
      end

      def resolve(**_args)
        if @post.destroy
          { post: @post }
        else
          errors = @post.errors.full_messages
          unprocessable_error(errors.join(', '))
        end
      end

      private

      def post(**args)
        @post ||= ::Post.find_by_id(args[:id])
      end

      def policy
        PostPolicy.new(current_user, @post)
      end
    end
  end
end
