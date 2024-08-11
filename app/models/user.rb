# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :citext           not null
#  locale                 :string           default("en")
#  name                   :string           not null
#  otp_enabled            :boolean          default(FALSE), not null
#  otp_secret_key         :string
#  password_digest        :string
#  password_reset_sent_at :datetime
#  password_reset_token   :string
#  uuid                   :uuid             not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_uuid   (uuid) UNIQUE
#
class User < ApplicationRecord
  include HasUuid

  PASSWORD_FORMAT = /\A
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
    .{8,}              # Must contain 8 or more characters
  \z/x

  has_secure_password

  has_one_time_password backup_codes_count: 6

  has_many :sessions, dependent: :destroy
  has_many :posts, dependent: :destroy

  before_validation :process_otp_action

  validates :email, presence: true, email: true, uniqueness: true
  validates :name, presence: true
  validates :password, format: { with: PASSWORD_FORMAT }, allow_blank: true

  def save_password_reset_token
    generate_unique_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
  end

  # @rbs return: String
  def otp_provisioning_url
    provisioning_uri
  end

  def otp_action=(input)
    @otp_action = input.to_h
  end

  def process_otp_action
    # otp_action = nil OR {} OR {enable:, code:}
    return if @otp_action.blank?

    if @otp_action[:enable]
      enable_otp
    else
      disable_otp
    end
  end

  def enable_otp
    code = @otp_action[:code]
    if authenticate_otp(code, drift: 60)
      self.otp_enabled = true
    else
      errors.add(:otp_code)
    end
  end

  def disable_otp
    code = @otp_action[:code]
    if authenticate_otp(code, drift: 60)
      self.otp_secret_key = User.otp_random_secret
      self.otp_enabled = false
    else
      errors.add(:otp_code)
    end
  end
end
