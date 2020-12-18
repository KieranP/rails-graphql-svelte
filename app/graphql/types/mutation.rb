module Types
  class Mutation < GraphQL::Schema::RelayClassicMutation
    argument_class Argument
    field_class Field
    input_object_class Input
    object_class Object

    include QueryHelpers
  end
end
