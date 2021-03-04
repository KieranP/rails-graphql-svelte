# frozen_string_literal: true

class AddUniqIndexToUserEmail < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :email, unique: true
  end
end
