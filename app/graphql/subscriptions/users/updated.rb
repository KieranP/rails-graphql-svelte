module Subscriptions::Users
  class Updated < Types::Subscription
    payload_type Objects::User

    argument :id, ID, required: true

    def update(**args)
      unless user = find_user(args)
        raise GraphQL::ExecutionError.new('User Not Found', options: { code: 404 })
      end
      user
    end

    private

    def find_user(**args)
      @user ||= User.find_by_id(args[:id])
    end
  end
end
