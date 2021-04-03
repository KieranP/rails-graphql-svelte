# frozen_string_literal: true

module Mutations
  module Post
    class Update < Mutations::Base
      graphql_name 'PostUpdate'

      argument :uuid, ID, required: true
      argument :title, String, required: true
      argument :body, String, required: true

      field :post, Objects::Post, null: true

      def authorized?(**args)
        raise unauthorised_error unless logged_in?
        raise not_found_error('Post Not Found') unless post(**args)
        raise forbidden_error unless policy.update?

        true
      end

      def resolve(**args)
        result = UpdatePost.call(post: @post, args: args)
        if result.success?
          post = result.post
          trigger(:post_updated, { uuid: post.uuid }, post)
          { post: post }
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
