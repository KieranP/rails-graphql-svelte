# frozen_string_literal: true

class AddUniqueIndexToUserEmail < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :users, 'lower(email)', unique: true, algorithm: :concurrently
  end
end
