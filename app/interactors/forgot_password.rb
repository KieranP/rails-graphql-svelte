# frozen_string_literal: true

class ForgotPassword
  include Interaktor

  input do
    required :email
  end

  def call
    user = User.find_by(email: email)

    if user&.save_password_reset_token
      UserMailer.forgot_password(user.id).deliver_later
      success!
    else
      fail!
    end
  end
end
