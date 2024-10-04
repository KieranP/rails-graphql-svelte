# frozen_string_literal: true

module Objects
  class Base < GraphQL::Schema::Object
    field_class Types::Field

    include ObjectHelpers

    class << self
      def policy(policy)
        @policy = policy
      end

      def authorized?(obj, ctx)
        super && pundit_authorized?(obj, ctx)
      end

      def pundit_authorized?(obj, ctx)
        return true unless @policy

        user = ctx[:current_user]
        policy = Pundit.policy(user, obj)
        policy.send(@policy)
      end
    end
  end
end
