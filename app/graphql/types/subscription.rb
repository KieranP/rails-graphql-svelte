module Types
  class Subscription < GraphQL::Schema::Subscription
    argument_class Argument
    field_class Field
    object_class Object
  end
end
