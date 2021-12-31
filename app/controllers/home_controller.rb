# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render layout: true, html: ''
  end
end
