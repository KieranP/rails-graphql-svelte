# frozen_string_literal: true

class AuthenticateUser
  include Interaktor

  input do
    required :email
    required :password
    optional :otp_code
  end

  success do
    required :user
  end

  failure do
    required :errors
  end

  def call
    user = User.find_by(email: email)

    if user&.authenticate(password)
      if user.otp_enabled?
        validate_otp_code(user)
      else
        success!(user: user)
      end
    else
      fail!(errors: ['Email and password are not valid'])
    end
  end

  def validate_otp_code(user)
    if otp_code.blank?
      fail!(errors: ['otp_code_required'])
    elsif user.authenticate_otp(otp_code.to_s, drift: 30)
      success!(user: user)
    else
      fail!(errors: ['OTP Code is incorrect'])
    end
  end
end
