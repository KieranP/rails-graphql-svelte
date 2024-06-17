# frozen_string_literal: true

require 'rails_helper'

feature 'Posts', :js do
  let(:user) { create(:user) }

  describe '/posts' do
    let(:posts) { create_list(:post, 50) }

    it 'returns pageable results' do
      posts

      visit '/posts'
      expect(page).to have_content posts[0].title
      expect(page).to have_content 'Next'
      expect(page).to have_no_content 'Prev'

      click_on 'Next'

      expect(page).to have_content posts[20].title
      expect(page).to have_content 'Next'
      expect(page).to have_content 'Prev'

      click_on 'Next'

      expect(page).to have_content posts[40].title
      expect(page).to have_no_content 'Next'
      expect(page).to have_content 'Prev'

      click_on 'Prev'

      expect(page).to have_content posts[20].title
      expect(page).to have_content 'Next'
      expect(page).to have_content 'Prev'

      click_on 'Prev'

      expect(page).to have_content posts[0].title
      expect(page).to have_content 'Next'
      expect(page).to have_no_content 'Prev'

      click_on 'Next'

      expect(page).to have_content posts[20].title
      expect(page).to have_content 'Next'
      expect(page).to have_content 'Prev'
    end
  end

  describe '/posts/new' do
    before { login(user) }

    it do
      expect {
        visit '/posts/new'

        fill_in 'Title', with: 'Sample Title'
        fill_in 'Body', with: 'Sample Body'
        click_on 'Create'

        expect(page).to have_content 'Sample Title'
        expect(page).to have_content 'Sample Body'
      }.to change(Post, :count).by 1
    end
  end

  describe '/posts/:uuid' do
    let(:post) { create(:post) }

    before { login(user) }

    it do
      visit "/posts/#{post.uuid}"

      expect(page).to have_content post.title
      expect(page).to have_content post.body
    end
  end

  describe '/posts/:uuid/edit' do
    let(:post) { create(:post, user: user) }

    before { login(user) }

    it do
      visit "/posts/#{post.uuid}/edit"

      new_title = Faker::Lorem.question
      new_body = Faker::Lorem.paragraph

      fill_in 'Title', with: new_title
      fill_in 'Body', with: new_body
      click_on 'Update'

      expect(page).to have_content new_title
      expect(page).to have_content new_body

      post.reload
      expect(post.title).to eq new_title
      expect(post.body).to eq new_body
    end
  end
end
