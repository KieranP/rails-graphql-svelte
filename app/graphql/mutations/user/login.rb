module Mutations::User
  class Login < Types::Mutation
    graphql_name "UserLogin"

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

      # Used by Web UI, prevents XSS attacks
      cookies.signed['jwt_token'] = {
        value: token,
        httponly: true,
        domain: ENV['COOKIE_DOMAIN'],
        expires: 1.year.from_now
      }

      { user: user, token: token }
    end
  end
end
