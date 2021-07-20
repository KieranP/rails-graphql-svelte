# frozen_string_literal: true

class AddPasswordResetTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :password_reset_token
      t.datetime :password_reset_sent_at
    end
  end
end
