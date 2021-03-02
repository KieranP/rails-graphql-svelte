# frozen_string_literal: true

module Types
  module Interface
    include GraphQL::Schema::Interface

    field_class Field
  end
end
