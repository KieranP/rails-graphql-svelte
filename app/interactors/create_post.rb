# frozen_string_literal: true

class CreatePost
  include Interaktor

  input do
    required :user
    required :args
  end

  success do
    required :post
  end

  failure do
    required :errors
  end

  def call
    post = user.posts.new(args)
    if post.save
      success!(post: post)
    else
      errors = post.errors.full_messages
      fail!(errors: errors)
    end
  end
end
