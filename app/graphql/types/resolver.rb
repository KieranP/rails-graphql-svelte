module Types
  class Resolver < GraphQL::Schema::Resolver
    argument_class Argument

    include QueryHelpers
  end
end
