# frozen_string_literal: true

require 'rails_helper'

feature 'Users', type: :feature, js: true do
  let(:user) { create(:user) }

  describe '/users/:id' do
    before { login(user) }

    it do
      visit "/users/#{user.id}"

      expect(page).to have_content user.name
      expect(page).to have_content user.email
    end
  end

  describe '/users/:id/edit' do
    before { login(user) }

    it do
      visit "/users/#{user.id}/edit"

      new_name = Faker::Name.name
      new_email = Faker::Internet.email

      fill_in 'Name', with: new_name
      fill_in 'Email', with: new_email
      click_button 'Update'

      expect(page).to have_content new_name
      expect(page).to have_content new_email

      user.reload
      expect(user.name).to eq new_name
      expect(user.email).to eq new_email
    end
  end
end
