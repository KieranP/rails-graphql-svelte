# frozen_string_literal: true

module Subscriptions
  module Posts
    class Updated < Types::Subscription
      payload_type Objects::Post

      argument :id, ID, required: true

      def update(**args)
        unless post = post(args)
          raise GraphQL::ExecutionError.new('Post Not Found', options: { code: 404 })
        end

        post
      end

      private

      def post(**args)
        @post ||= ::Post.find_by_id(args[:id])
      end
    end
  end
end
