# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :update_session

  rescue_from JWT::InvalidIatError, JWT::InvalidJtiError, with: :invalid_jwt

  def current_user
    @current_user ||= begin
      return unless jwt_payload

      uuid = jwt_payload.dig('user', 'uuid')
      User.find_by_uuid(uuid)
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

  def current_session
    @current_session ||= begin
      return unless jwt_payload

      jti = jwt_payload['jti']
      Session.find_by_jwt_id(jti)
    end
  end

  private

  def invalid_jwt
    render json: {
      errors: [{
        code: 401,
        message: 'Invalid JWT Token'
      }]
    }
  end

  def update_session
    return unless current_session

    current_session.mark_visit!
  end
end
