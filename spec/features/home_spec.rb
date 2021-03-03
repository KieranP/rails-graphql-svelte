# frozen_string_literal: true

require 'rails_helper'

feature 'Home', type: :feature, js: true do
  it 'loads' do
    visit '/'
    expect(page).to have_content 'Home'
  end
end
