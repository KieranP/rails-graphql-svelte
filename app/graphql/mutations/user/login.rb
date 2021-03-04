# frozen_string_literal: true

module Mutations
  module User
    class Login < Types::Mutation
      graphql_name 'UserLogin'

      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Objects::User, null: true
      field :token, String, null: true

      def resolve(email:, password:)
        user = ::User.find_by(email: email)
        valid = user&.authenticate(password)
        raise forbidden_error unless valid

        session = user.sessions.create!
        token = generate_jwt(user, session)

        { user: user, token: token }
      end
    end
  end
end
