module Mutations::User
  class Create < Types::Mutation
    graphql_name "UserCreate"

    argument :email, String, required: true
    argument :name, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    field :user, Objects::User, null: true
    field :token, String, null: true

    def authorized?(**args)
      raise forbidden_error unless policy.create?
      true
    end

    def resolve(**args)
      user = User.new(args)
      if user.save
        session = user.sessions.create!
        token = generate_jwt(user, session)

        { user: user, token: token }
      else
        errors = user.errors.full_messages
        unprocessable_error(errors.join(', '))
      end
    end

    private

    def policy
      PostPolicy.new(current_user, nil)
    end
  end
end
