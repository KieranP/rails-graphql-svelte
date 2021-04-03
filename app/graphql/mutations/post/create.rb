# frozen_string_literal: true

module Mutations
  module Post
    class Create < Mutations::Base
      graphql_name 'PostCreate'

      argument :title, String, required: true
      argument :body, String, required: true

      field :post, Objects::Post, null: true

      def authorized?(**_args)
        raise unauthorised_error unless logged_in?
        raise forbidden_error unless policy.create?

        true
      end

      def resolve(**args)
        result = CreatePost.call(user: current_user, args: args)
        if result.success?
          { post: result.post }
        else
          errors = result.errors.join(', ')
          unprocessable_error(errors)
        end
      end

      private

      def policy
        PostPolicy.new(current_user, nil)
      end
    end
  end
end
