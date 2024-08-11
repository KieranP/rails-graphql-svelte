# frozen_string_literal: true

class JwtToken
  # @rbs user: ::User
  # @rbs session: ::Session
  # @rbs return: ::String
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

    JWT.encode(payload, ENV.fetch('JWT_SECRET'), 'HS256')
  end

  # @rbs jwt_token: ::String
  # @rbs return: untyped | ::Hash[::String, untyped]
  def self.decode(jwt_token)
    JWT.decode(jwt_token, ENV.fetch('JWT_SECRET'), true, {
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
      domain: ENV.fetch('COOKIE_DOMAIN'),
      expires: 1.year.from_now
    }
  end
end
