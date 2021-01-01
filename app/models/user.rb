# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  locale          :string           default("en")
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
