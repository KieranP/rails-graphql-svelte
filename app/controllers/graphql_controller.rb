# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    render json: Schema.execute(**schema_options)
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development e
  end

  private

  def schema_options
    {
      query: params[:query],
      operation_name: params[:operationName],
      variables: ensure_hash(params[:variables]),
      context: {
        current_user: current_user,
        session: current_session,
        cookies: cookies
      }
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
    logger.error err.message
    logger.error err.backtrace.join("\n")

    render json: { errors: [{ message: err.message, backtrace: err.backtrace }], data: {} }, status: 500
  end
end
