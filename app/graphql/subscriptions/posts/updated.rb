module Subscriptions::Posts
  class Updated < Types::Subscription
    payload_type Objects::Post

    argument :id, ID, required: true

    def update(**args)
      unless post = find_post(args)
        raise GraphQL::ExecutionError.new('Post Not Found', options: { code: 404 })
      end
      post
    end

    private

    def find_post(**args)
      @post ||= Post.find_by_id(args[:id])
    end
  end
end
