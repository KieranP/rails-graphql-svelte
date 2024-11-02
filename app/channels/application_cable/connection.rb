# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = current_user
    end

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
  end
end
