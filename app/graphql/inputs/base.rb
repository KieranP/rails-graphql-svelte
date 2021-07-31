# frozen_string_literal: true

module Inputs
  class Base < GraphQL::Schema::InputObject
    argument_class Types::Argument
  end
end
