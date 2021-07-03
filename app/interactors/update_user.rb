# frozen_string_literal: true

class UpdateUser
  include Interaktor

  input do
    required :user
    required :args
  end

  success do
    required :user
  end

  failure do
    required :errors
  end

  def call
    if user.update(args.except(:uuid))
      success!(user: user)
    else
      errors = user.errors.full_messages
      fail!(errors: errors)
    end
  end
end
