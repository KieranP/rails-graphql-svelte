# frozen_string_literal: true

require 'rails_helper'

describe Post, type: :model do
  it 'requires a title and body' do
    post = Post.new
    expect(post.valid?).to eq false
    expect(post.errors).to include :title
    expect(post.errors).to include :body
  end
end
