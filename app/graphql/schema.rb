
class Schema < GraphQL::Schema
  subscription Types::Subscriptions
  mutation Types::Mutations
  query Types::Queries

  # max_complexity 100
  # max_depth 3

  use GraphQL::Backtrace
  use GraphQL::Batch

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST

  # use GraphQL::Execution::Errors

  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections

  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new

  # query_analyzer Analyzers::QueryComplexity
  # query_analyzer Analyzers::QueryDepth
end
