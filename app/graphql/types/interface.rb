# frozen_string_literal: true

module Types
  module Interface
    include GraphQL::Schema::Interface

    field_class Types::Field
  end
end
