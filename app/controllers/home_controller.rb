# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render 'public/index.html'
  end
end
