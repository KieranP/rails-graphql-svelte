class JwtToken
  def self.generate(user, session)
    payload = {
      iat: session.created_at.to_i,
      exp: session.expires_at.to_i,
      jti: session.jwt_id,
      user: {
        id: user.id,
        name: user.name
      }
    }

    JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
  end

  def self.decode(jwt_token)
    JWT.decode(jwt_token, ENV['JWT_SECRET'], true, {
      verify_iat: true,
      verify_jti: proc { |jti|
        Session.where(jwt_id: jti).exists?
      }
    })
  end
end
