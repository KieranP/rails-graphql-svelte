class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :update_session

  # rescue_from(JWT::InvalidIatError) {} # TODO
  # rescue_from(JWT::InvalidJtiError) {} # TODO

  def current_user
    @current_user ||= begin
      return unless jwt_payload

      id = jwt_payload.dig('user', 'id')
      User.find_by_id(id)
    end
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

  def jwt_payload
    @jwt_payload ||= jwt_token&.first
  end

  def current_session
    @current_session ||= begin
      return unless jwt_payload

      jti = jwt_payload.dig('jti')
      Session.find_by_jwt_id(jti)
    end
  end

  private

  def update_session
    return unless current_session
    current_session.mark_visit!
  end
end
