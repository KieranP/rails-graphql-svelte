# frozen_string_literal: true

require 'rails_helper'

feature 'About', type: :feature, js: true do
  it 'loads' do
    visit '/about'
    expect(page).to have_content 'About'
  end
end
