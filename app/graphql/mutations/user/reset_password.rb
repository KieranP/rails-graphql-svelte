# frozen_string_literal: true

module Mutations
  module User
    class ResetPassword < Mutations::Base
      graphql_name 'UserResetPassword'

      argument :token, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      field :success, Boolean, null: false

      def resolve(**args)
        result = ::ResetPassword.call(**args)
        if result.success?
          { success: true }
        else
          errors = result.errors.join(', ')
          unprocessable_error(errors)
        end
      end
    end
  end
end
