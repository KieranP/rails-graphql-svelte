# frozen_string_literal: true

module Subscriptions
  module Posts
    class Updated < Subscriptions::Base
      payload_type Objects::Post

      argument :uuid, ID, required: true

      def update(**args)
        unless (post = post(**args))
          raise GraphQL::ExecutionError.new('Post Not Found', options: { code: 404 })
        end

        post
      end

      private

      def post(**args)
        @post ||= ::Post.find_by(uuid: args[:uuid])
      end
    end
  end
end
