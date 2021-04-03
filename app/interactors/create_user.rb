# frozen_string_literal: true

class CreateUser
  include Interaktor

  required :args

  success :user

  failure :errors

  def call
    user = User.new(args)

    if user.save
      success!(user: user)
    else
      errors = user.errors.full_messages
      fail!(errors: errors)
    end
  end
end
