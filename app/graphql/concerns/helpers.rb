module Helpers
  include ActiveSupport::Concern

  def current_user
    context[:current_user]
  end

  def cookies
    context[:cookies]
  end

  def logged_in?
    current_user.present?
  end

  def unauthorised_error
    GraphQL::ExecutionError.new("Unauthorized",
      options: { code: 401, status: :unauthorized })
  end

  def forbidden_error
    GraphQL::ExecutionError.new("Forbidden",
      options: { code: 403, status: :forbidden })
  end

  def not_found_error
    GraphQL::ExecutionError.new("Not Found",
      options: { code: 404, status: :not_found })
  end

  def execution_error(message)
    GraphQL::ExecutionError.new(message,
      options: { code: 422, status: :unprocessable_entity })
  end
end
