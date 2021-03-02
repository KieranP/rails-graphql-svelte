# frozen_string_literal: true

class HomeController < ActionController::Base
  def index
    render file: 'public/index.html'
  end
end
