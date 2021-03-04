# frozen_string_literal: true

class AddUuidsToUserAndPost < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_index :users, :uuid, unique: true

    add_column :posts, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_index :posts, :uuid, unique: true

    add_column :sessions, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_index :sessions, :uuid, unique: true
  end
end
