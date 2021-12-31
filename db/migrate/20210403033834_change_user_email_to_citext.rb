# frozen_string_literal: true

class ChangeUserEmailToCitext < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :email
    enable_extension :citext

    # rubocop:disable Rails/ReversibleMigration
    safety_assured { change_column :users, :email, :citext }
    # rubocop:enable Rails/ReversibleMigration
  end
end
