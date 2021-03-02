# frozen_string_literal: true

module Resolvers
  module User
    class Show < Types::Resolver
      graphql_name 'UserShow'

      type Objects::User, null: false

      argument :id, ID, required: true

      def authorized?(**args)
        raise not_found_error('User Not Found') unless user(**args)
        raise forbidden_error unless policy.show?

        true
      end

      def resolve(**_args)
        @user
      end

      private

      def user(**args)
        @user ||= ::User.find_by_id(args[:id])
      end

      def policy
        UserPolicy.new(current_user, @user)
      end
    end
  end
end
