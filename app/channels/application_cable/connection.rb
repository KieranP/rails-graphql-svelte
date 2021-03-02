# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = current_user
    end

    private

    def current_user
      @current_user ||= begin
        return unless jwt_payload

        id = jwt_payload.dig('user', 'id')
        User.find_by_id(id)
      end
    end

    def jwt_payload
      @jwt_payload ||= jwt_token&.first
    end

    def jwt_token
      @jwt_token ||= begin
        auth_token = request.headers['Authorization']
        auth_token ||= cookies.signed['jwt_token']
        return unless auth_token

        jwt_token = auth_token.remove('Bearer ')
        JwtToken.decode(jwt_token)
      end
    end
  end
end
