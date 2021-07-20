# frozen_string_literal: true

class ResetPassword
  include Interaktor

  input do
    required :token
    required :email
    required :password
    required :password_confirmation
  end

  failure do
    required :errors
  end

  def call
    user = User.find_by(email: email, password_reset_token: token)
    return fail!(errors: ['No user found matching the given email or reset token']) unless user

    if user.password_reset_sent_at < 1.hour.ago
      return fail!(errors: ['Password reset token expired, start reset process again'])
    end

    user.password = password
    user.password_confirmation = password_confirmation
    user.password_reset_token = nil
    user.password_reset_sent_at = nil

    if user.save
      success!
    else
      errors = user.errors.full_messages
      fail!(errors: errors)
    end
  end
end
