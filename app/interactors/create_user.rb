# frozen_string_literal: true

class CreateUser
  include Interaktor

  input do
    required :args
  end

  success do
    required :user
  end

  failure do
    required :errors
  end

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
