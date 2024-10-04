# frozen_string_literal: true

module Mutations
  module User
    class Login < Mutations::Base
      graphql_name 'UserLogin'

      argument :email, String, required: true
      argument :password, String, required: true
      argument :otp_code, String, required: false

      field :user, Objects::User, null: true
      field :token, String, null: true

      def resolve(email:, password:, otp_code: nil)
        result = AuthenticateUser.call(
          email: email,
          password: password,
          otp_code: otp_code,
        )

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
