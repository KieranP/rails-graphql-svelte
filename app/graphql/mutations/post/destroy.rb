# frozen_string_literal: true

module Mutations
  module Post
    class Destroy < Mutations::Base
      graphql_name 'PostDestroy'

      argument :uuid, ID, required: true

      field :post, Objects::Post, null: true

      def authorized?(**args)
        raise unauthorised_error unless logged_in?
        raise not_found_error('Post Not Found') unless post(**args)
        raise forbidden_error unless policy.destroy?

        true
      end

      def resolve(**_args)
        result = DestroyPost.call(post: @post)
        if result.success?
          { post: result.post }
        else
          errors = result.errors.join(', ')
          unprocessable_error(errors)
        end
      end

      private

      def post(**args)
        @post ||= ::Post.find_by(uuid: args[:uuid])
      end

      def policy
        PostPolicy.new(current_user, @post)
      end
    end
  end
end
