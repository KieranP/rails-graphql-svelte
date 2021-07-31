# frozen_string_literal: true

class AddOtpSecretKeyToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :otp_secret_key, :string

    User.reset_column_information
    User.find_each do |user|
      # rubocop:disable Rails/SkipsModelValidations
      user.update_attribute(:otp_secret_key, User.otp_random_secret)
      # rubocop:enable Rails/SkipsModelValidations
    end
  end

  def down
    remove_column :users, :otp_secret_key
  end
end
