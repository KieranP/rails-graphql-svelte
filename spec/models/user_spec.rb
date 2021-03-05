# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  locale          :string           default("en")
#  name            :string
#  password_digest :string
#  uuid            :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_uuid   (uuid) UNIQUE
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
