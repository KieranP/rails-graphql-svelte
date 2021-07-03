# frozen_string_literal: true

class AuthenticateUser
  include Interaktor

  input do
    required :email
    required :password
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
      success!(user: user)
    else
      fail!(errors: ['Email and password are not valid'])
    end
  end
end
