module Resolvers::User
  class Show < Types::Resolver
    graphql_name "UserShow"

    type Objects::User, null: false

    argument :id, ID, required: true

    def ready?(**args)
      raise not_found_error unless find_user(**args)
      raise forbidden_error unless policy.show?
      true
    end

    def resolve(**args)
      @user
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