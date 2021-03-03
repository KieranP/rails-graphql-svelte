# frozen_string_literal: true

class TestingController < ActionController::Base
  before_action do
    head(403) unless Rails.env.test?
  end

  def login
    user = User.find(params[:id])
    session = user.sessions.create!
    jwt_token = JwtToken.generate(user, session)
    JwtToken.set_cookie(cookies, jwt_token)
    head 202
  end

  def logout
    cookies.delete('jwt_token')
    head 202
  end
end
