# frozen_string_literal: true

require 'graphql/rake_task'

GraphQL::RakeTask.new(
  schema_name: 'Schema',
  idl_outfile: 'app/graphql/schema.graphql',
  json_outfile: 'app/graphql/schema.json',
)
