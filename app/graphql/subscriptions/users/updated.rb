# frozen_string_literal: true

module Subscriptions
  module Users
    class Updated < Types::Subscription
      payload_type Objects::User

      argument :id, ID, required: true

      def update(**args)
        unless user = user(args)
          raise GraphQL::ExecutionError.new('User Not Found', options: { code: 404 })
        end

        user
      end

      private

      def user(**args)
        @user ||= ::User.find_by_id(args[:id])
      end
    end
  end
end
