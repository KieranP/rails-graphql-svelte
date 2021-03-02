# frozen_string_literal: true

class AddExpiresAtToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :expires_at, :datetime
  end
end
