# frozen_string_literal: true

class UpdatePost
  include Interaktor

  required :post
  required :args

  success :post

  failure :errors

  def call
    if post.update(args.except(:uuid))
      success!(post: post)
    else
      errors = post.errors.full_messages
      fail!(errors: errors)
    end
  end
end
