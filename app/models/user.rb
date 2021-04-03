# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :citext           not null
#  locale          :string           default("en")
#  name            :string           not null
#  password_digest :string
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_lower_email  (lower((email)::text)) UNIQUE
#  index_users_on_uuid         (uuid) UNIQUE
#
class User < ApplicationRecord
  include HasUuid

  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, format: { with: PASSWORD_FORMAT }, allow_blank: true
end
