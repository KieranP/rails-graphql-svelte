# frozen_string_literal: true

module Subscriptions
  class Base < GraphQL::Schema::Subscription
    argument_class Types::Argument
    field_class Types::Field
    object_class Objects::Base
  end
end
