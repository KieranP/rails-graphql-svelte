# frozen_string_literal: true

class AddUniqueIndexToUserEmailV2 < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    # rubocop:disable Rails/ReversibleMigration
    remove_index :users, name: 'index_users_on_lower_email'
    # rubocop:enable Rails/ReversibleMigration

    add_index :users, :email, unique: true, algorithm: :concurrently
  end
end
