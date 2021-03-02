# frozen_string_literal: true

module Mutations
  module User
    class Logout < Types::Mutation
      graphql_name 'UserLogout'

      field :user, Objects::User, null: true

      def resolve
        cookies.delete('jwt_token')
        { user: current_user }
      end
    end
  end
end
