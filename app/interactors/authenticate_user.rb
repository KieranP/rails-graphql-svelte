# frozen_string_literal: true

class AuthenticateUser
  include Interaktor

  required :email
  required :password

  success :user

  failure :errors

  def call
    user = User.find_by(email: email)

    if user&.authenticate(password)
      success!(user: user)
    else
      fail!(errors: ['Email and password are not valid'])
    end
  end
end
