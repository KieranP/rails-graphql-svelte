# frozen_string_literal: true

class FixDatabaseInconsistenciesV2 < ActiveRecord::Migration[6.1]
  def change
    safety_assured do
      change_column_null :posts, :user_id, false
    end
  end
end
