# frozen_string_literal: true

class AddOtpEnabledToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :otp_enabled, :boolean, default: false, null: false
  end
end
