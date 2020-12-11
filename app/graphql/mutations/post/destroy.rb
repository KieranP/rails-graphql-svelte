module Mutations::Post
  class Destroy < Types::Mutation
    graphql_name "PostDestroy"

    argument :id, ID, required: true

    field :post, Objects::Post, null: true

    def ready?(**args)
      raise unauthorised_error unless logged_in?
      raise not_found_error unless find_post(**args)
      raise forbidden_error unless policy.destroy?
      true
    end

    def resolve(**args)
      if @post.destroy
        { post: @post }
      else
        errors = @post.errors.full_messages
        execution_error(errors.join(', '))
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
