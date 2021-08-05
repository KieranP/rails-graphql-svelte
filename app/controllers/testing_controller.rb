# frozen_string_literal: true

class TestingController < ApplicationController
  before_action do
    head(:forbidden) unless Rails.env.test?
  end

  def login
    user = User.find_by(uuid: params[:uuid])
    session = user.sessions.create!
    jwt_token = JwtToken.generate(user, session)
    JwtToken.set_cookie(cookies, jwt_token)
    head :accepted
  end

  def logout
    cookies.delete('jwt_token')
    head :accepted
  end
end
