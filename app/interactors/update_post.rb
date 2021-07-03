# frozen_string_literal: true

class UpdatePost
  include Interaktor

  input do
    required :post
    required :args
  end

  success do
    required :post
  end

  failure do
    required :errors
  end

  def call
    if post.update(args.except(:uuid))
      success!(post: post)
    else
      errors = post.errors.full_messages
      fail!(errors: errors)
    end
  end
end
