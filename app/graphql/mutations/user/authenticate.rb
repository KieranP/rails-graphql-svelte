module Mutations::User
  class Authenticate < Types::Mutation
    graphql_name "UserAuthenticate"

    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Objects::User, null: true
    field :token, String, null: true

    def resolve(email:, password:)
      user = User.find_by_email(email)
      valid = user&.authenticate(password)
      raise forbidden_error unless valid

      session = user.sessions.create!
      token = JwtToken.generate(user, session)
      { user: user, token: token }
    end
  end
end
