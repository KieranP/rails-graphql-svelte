# frozen_string_literal: true

class AddUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :posts, :user, foreign_key: true
  end
end
