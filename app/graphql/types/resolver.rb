module Types
  class Resolver < GraphQL::Schema::Resolver
    argument_class Argument

    include Helpers
  end
end
