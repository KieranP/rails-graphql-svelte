module QueryHelpers
  extend ActiveSupport::Concern

  def current_user
    context[:current_user]
  end

  def cookies
    context[:cookies]
  end

  def logged_in?
    current_user.present?
  end

  def trigger(*args)
    Schema.subscriptions.trigger(*args)
  end

  def execution_error(message, code = 500)
    msg ||= "Execution Error"
    GraphQL::ExecutionError.new(message, options: { code: code })
  end

  def unauthorised_error(msg = nil)
    msg ||= "Unauthorized"
    execution_error(msg, 401)
  end

  def forbidden_error(msg = nil)
    msg ||= "Forbidden"
    execution_error(msg, 403)
  end

  def not_found_error(msg = nil)
    msg ||= "Not Found"
    execution_error(msg, 404)
  end

  def unprocessable_error(msg = nil)
    msg ||= "Unprocessable"
    execution_error(msg, 422)
  end
end
