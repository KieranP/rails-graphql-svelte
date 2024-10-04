# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def forgot_password(user_id)
    @recipient = User.find(user_id)

    email = Base64.urlsafe_encode64(@recipient.email)
    token = Base64.urlsafe_encode64(@recipient.password_reset_token)
    @url = url("/reset-password?email=#{email}&token=#{token}")

    mail(
      subject: t('.subject'),
    )
  end
end
