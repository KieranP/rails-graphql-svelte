# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ProsopiteHooks

  allow_browser versions: :modern
end
