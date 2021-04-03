# frozen_string_literal: true

class DestroyPost
  include Interaktor

  required :post

  success :post

  failure :errors

  def call
    if post.destroy
      success!(post: post)
    else
      errors = post.errors.full_messages
      fail!(errors: errors)
    end
  end
end
