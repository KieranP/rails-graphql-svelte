# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :citext           not null
#  locale                 :string           default("en")
#  name                   :string           not null
#  otp_enabled            :boolean          default(FALSE)
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
#  index_users_on_lower_email  (lower((email)::text)) UNIQUE
#  index_users_on_uuid         (uuid) UNIQUE
#
require 'rails_helper'

describe User, type: :model do
  it 'requires an email and name' do
    user = described_class.new
    expect(user.valid?).to eq false
    expect(user.errors).to include :email
    expect(user.errors).to include :name
  end
end
