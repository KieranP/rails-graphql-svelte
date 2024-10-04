# frozen_string_literal: true

class GraphqlController < ActionController::API
  include ActionController::Cookies
  include ProsopiteHooks

  before_action :update_session

  rescue_from \
    JWT::InvalidIatError,
    JWT::InvalidJtiError,
    JWT::ExpiredSignature,
    with: :invalid_jwt

  def execute
    render json: Schema.execute(**schema_options)
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
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

  def auth_token
    @auth_token ||= begin
      auth_token = request.headers['Authorization']
      auth_token || cookies.signed['jwt_token']
    end
  end

  def jwt_token
    @jwt_token ||=
      if auth_token
        jwt_token = auth_token.remove('Bearer ')
        JwtToken.decode(jwt_token)
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

  def invalid_jwt
    render json: {
      errors: [{
        code: 401,
        message: 'Invalid JWT Token',
      }],
    }
  end

  def schema_options
    {
      query: params[:query],
      operation_name: params[:operationName],
      variables: ensure_hash(params[:variables]),
      context: {
        current_user: current_user,
        session: current_session,
        cookies: cookies,
      },
    }
  end

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(err)
    logger.error(err.message)
    logger.error(err.backtrace.join("\n"))

    render json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} },
      status: :internal_server_error
  end
end
