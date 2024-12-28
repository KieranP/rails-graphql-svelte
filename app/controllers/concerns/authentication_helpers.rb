# frozen_string_literal: true

module AuthenticationHelpers
  private

  def current_user
    @current_user ||=
      if jwt_payload
        uuid = jwt_payload.dig('user', 'uuid')
        User.find_by(uuid: uuid)
      end
  end

  def jwt_payload
    @jwt_payload ||= jwt_token&.first
  end

  def jwt_token
    @jwt_token ||=
      if auth_token
        jwt_token = auth_token.remove('Bearer ')
        JwtToken.decode(jwt_token)
      end
  end

  def auth_token
    @auth_token ||= begin
      auth_token = request.headers['Authorization']
      auth_token || cookies.signed['jwt_token']
    end
  end

  def current_session
    @current_session ||=
      if jwt_payload
        jti = jwt_payload['jti']
        Session.find_by(jwt_id: jti)
      end
  end

  def update_session
    current_session&.mark_visit!
  end
end
