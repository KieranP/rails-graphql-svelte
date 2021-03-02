# frozen_string_literal: true

module Types
  class Object < GraphQL::Schema::Object
    field_class Field

    include ObjectHelpers
  end
end
