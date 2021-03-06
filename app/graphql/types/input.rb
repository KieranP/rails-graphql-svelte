# frozen_string_literal: true

module Types
  class Input < GraphQL::Schema::InputObject
    argument_class Types::Argument
  end
end
