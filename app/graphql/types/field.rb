module Types
  class Field < GraphQL::Schema::Field
    argument_class Argument
  end
end
