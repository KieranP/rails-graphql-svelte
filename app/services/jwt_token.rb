# frozen_string_literal: true

class JwtToken
  def self.generate(user, session)
    payload = {
      iat: session.created_at.to_i,
      exp: session.expires_at.to_i,
      jti: session.jwt_id,
      user: {
        uuid: user.uuid,
        name: user.name,
        locale: user.locale
      }
    }

    JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
  end

  def self.decode(jwt_token)
    JWT.decode(jwt_token, ENV['JWT_SECRET'], true, {
      verify_iat: true,
      verify_jti: proc { |jti|
        Session.find_by(jwt_id: jti)
      }
    })
  end

  def self.set_cookie(cookies, token)
    # Used by Web UI, prevents XSS attacks
    cookies.signed['jwt_token'] = {
      value: token,
      httponly: true,
      domain: ENV['COOKIE_DOMAIN'],
      expires: 1.year.from_now
    }
  end
end
