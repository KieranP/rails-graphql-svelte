# frozen_string_literal: true

module Resolvers
  class Base < GraphQL::Schema::Resolver
    argument_class Types::Argument

    include QueryHelpers
  end
end
