# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  it 'requires an email and name' do
    user = User.new
    expect(user.valid?).to eq false
    expect(user.errors).to include :email
    expect(user.errors).to include :name
  end
end
