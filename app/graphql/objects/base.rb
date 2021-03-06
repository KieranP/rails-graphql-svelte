# frozen_string_literal: true

module Objects
  class Base < GraphQL::Schema::Object
    field_class Types::Field

    include ObjectHelpers
  end
end
