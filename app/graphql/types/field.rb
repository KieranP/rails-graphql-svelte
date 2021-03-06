# frozen_string_literal: true

module Types
  class Field < GraphQL::Schema::Field
    argument_class Types::Argument
  end
end
