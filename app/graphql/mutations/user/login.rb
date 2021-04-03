# frozen_string_literal: true

module Mutations
  module User
    class Login < Mutations::Base
      graphql_name 'UserLogin'

      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Objects::User, null: true
      field :token, String, null: true

      def resolve(email:, password:)
        result = AuthenticateUser.call(email: email, password: password)
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
    end
  end
end
