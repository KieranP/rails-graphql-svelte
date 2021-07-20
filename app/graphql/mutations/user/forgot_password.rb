# frozen_string_literal: true

module Mutations
  module User
    class ForgotPassword < Mutations::Base
      graphql_name 'UserForgotPassword'

      argument :email, String, required: true

      field :success, Boolean, null: false

      def resolve(**args)
        ::ForgotPassword.call(email: args[:email])

        # Always return success, even if the email doesn't
        # match user account, to prevent account snooping
        { success: true }
      end
    end
  end
end
