# frozen_string_literal: true

module Mutations
  module User
    class Update < Mutations::Base
      graphql_name 'UserUpdate'

      argument :uuid, ID, required: true
      argument :email, String, required: false
      argument :name, String, required: false
      argument :locale, String, required: false

      field :user, Objects::User, null: true
      field :token, String, null: true

      def authorized?(**args)
        raise unauthorised_error unless logged_in?
        raise not_found_error('User Not Found') unless user(**args)
        raise forbidden_error unless policy.update?

        true
      end

      def resolve(**args)
        result = UpdateUser.call(user: @user, args: args)
        if result.success?
          user = result.user
          trigger(:user_updated, { uuid: user.uuid }, user)
          token = generate_jwt(user, session)
          { user: user, token: token }
        else
          errors = result.errors.join(', ')
          unprocessable_error(errors)
        end
      end

      private

      def user(**args)
        @user ||= ::User.find_by(uuid: args[:uuid])
      end

      def policy
        UserPolicy.new(current_user, @user)
      end
    end
  end
end
