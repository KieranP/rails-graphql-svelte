class AddLocaleToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :locale, :string, default: 'en'
  end
end
