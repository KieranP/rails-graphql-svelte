# frozen_string_literal: true

require 'rails_helper'

feature 'About', :js do
  it 'loads' do
    visit '/about'
    expect(page).to have_content 'About'
  end
end
