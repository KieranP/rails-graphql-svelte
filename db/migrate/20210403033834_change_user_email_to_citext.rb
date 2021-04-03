# frozen_string_literal: true

class ChangeUserEmailToCitext < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :email
    enable_extension :citext
    safety_assured { change_column :users, :email, :citext }
  end
end
