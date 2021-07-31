# frozen_string_literal: true

module Mutations
  class Base < GraphQL::Schema::RelayClassicMutation
    argument_class Types::Argument
    field_class Types::Field
    input_object_class Inputs::Base
    object_class Objects::Base

    include QueryHelpers
  end
end
