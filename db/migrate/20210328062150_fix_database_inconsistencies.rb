# frozen_string_literal: true

class FixDatabaseInconsistencies < ActiveRecord::Migration[6.1]
  def change
    safety_assured do
      change_column_null :users, :email, false
      change_column_null :users, :name, false

      change_column :posts, :user_id, :bigint
      change_column_null :posts, :title, false
      change_column_null :posts, :body, false

      change_column :sessions, :user_id, :bigint
      change_column_null :sessions, :expires_at, false
    end
  end
end
