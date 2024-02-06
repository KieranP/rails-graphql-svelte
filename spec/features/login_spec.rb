# frozen_string_literal: true

require 'rails_helper'

feature 'Login', :js do
  let(:user) { create(:user, password: 'Testing123!') }

  it 'successfully logs in user' do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'Testing123!'
    click_button 'Login' # rubocop:disable Capybara/ClickLinkOrButtonStyle

    expect(page).to have_content 'Logout'
  end
end
