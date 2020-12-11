module Types
  class Input < GraphQL::Schema::InputObject
    argument_class Argument
  end
end
