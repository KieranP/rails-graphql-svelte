module Mutations::Post
  class Update < Types::Mutation
    graphql_name "PostUpdate"

    argument :id, ID, required: true
    argument :title, String, required: true
    argument :body, String, required: true

    field :post, Objects::Post, null: true

    def authorized?(**args)
      raise unauthorised_error unless logged_in?
      raise not_found_error('Post Not Found') unless find_post(**args)
      raise forbidden_error unless policy.update?
      true
    end

    def resolve(**args)
      if @post.update(args.except(:id))
        { post: @post }
      else
        errors = @post.errors.full_messages
        unprocessable_error(errors.join(', '))
      end
    end

    private

    def find_post(**args)
      @post ||= Post.find_by_id(args[:id])
    end

    def policy
      PostPolicy.new(current_user, @post)
    end
  end
end
