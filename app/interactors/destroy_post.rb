# frozen_string_literal: true

class DestroyPost
  include Interaktor

  input do
    required :post
  end

  success do
    required :post
  end

  failure do
    required :errors
  end

  def call
    if post.destroy
      success!(post: post)
    else
      errors = post.errors.full_messages
      fail!(errors: errors)
    end
  end
end
