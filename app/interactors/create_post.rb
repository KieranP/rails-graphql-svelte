# frozen_string_literal: true

class CreatePost
  include Interaktor

  required :user
  required :args

  success :post

  failure :errors

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
