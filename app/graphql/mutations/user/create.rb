# frozen_string_literal: true

module Mutations
  module User
    class Create < Mutations::Base
      graphql_name 'UserCreate'

      argument :email, String, required: true
      argument :name, String, required: true
      argument :locale, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :user, Objects::User, null: true
      field :token, String, null: true

      def authorized?(**_args)
        raise forbidden_error unless policy.create?

        true
      end

      def resolve(**args)
        result = CreateUser.call(args: args)
        if result.success?
          user = result.user
          session = user.sessions.create!
          token = generate_jwt(user, session)
          { user: user, token: token }
        else
          errors = result.errors.join(', ')
          unprocessable_error(errors)
        end
      end

      private

      def policy
        UserPolicy.new(current_user, nil)
      end
    end
  end
end
