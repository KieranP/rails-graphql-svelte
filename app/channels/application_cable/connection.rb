# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include AuthenticationHelpers

    identified_by :current_user

    def connect
      self.current_user = current_user
    end
  end
end
