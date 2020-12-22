module Mutations::User
  class Update < Types::Mutation
    graphql_name "UserUpdate"

    argument :id, ID, required: true
    argument :email, String, required: false
    argument :name, String, required: false

    field :user, Objects::User, null: true

    def authorized?(**args)
      raise unauthorised_error unless logged_in?
      raise not_found_error('User Not Found') unless find_user(**args)
      raise forbidden_error unless policy.update?
      true
    end

    def resolve(**args)
      if @user.update(args.except(:id))
        trigger(:user_updated, {id: @user.id}, @user)
        { user: @user }
      else
        errors = @user.errors.full_messages
        unprocessable_error(errors.join(', '))
      end
    end

    private

    def find_user(**args)
      @user ||= User.find_by_id(args[:id])
    end

    def policy
      UserPolicy.new(current_user, @user)
    end
  end
end
