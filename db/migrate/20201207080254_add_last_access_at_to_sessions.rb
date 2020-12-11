class AddLastAccessAtToSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :last_access_at, :datetime
  end
end
