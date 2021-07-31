# frozen_string_literal: true

module Types
  class Field < GraphQL::Schema::Field
    argument_class Types::Argument

    def initialize(*args, **kwargs, &block)
      @policy = kwargs.delete(:policy)
      super(*args, **kwargs, &block)
    end

    def authorized?(obj, args, ctx)
      super && pundit_authorized?(obj, args, ctx)
    end

    def pundit_authorized?(obj, _args, ctx)
      return true unless @policy

      user = ctx[:current_user]
      policy = Pundit.policy(user, obj)
      policy.send(@policy)
    end
  end
end
