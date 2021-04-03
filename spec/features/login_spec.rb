# frozen_string_literal: true

require 'rails_helper'

feature 'Login', type: :feature, js: true do
  let(:user) { create(:user, password: 'Testing123!') }

  it 'successfully logs in user' do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'Testing123!'
    click_button 'Login'

    expect(page).to have_content 'Logout'
  end
end
