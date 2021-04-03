# frozen_string_literal: true

class UpdateUser
  include Interaktor

  required :user
  required :args

  success :user

  failure :errors

  def call
    if user.update(args.except(:uuid))
      success!(user: user)
    else
      errors = user.errors.full_messages
      fail!(errors: errors)
    end
  end
end
