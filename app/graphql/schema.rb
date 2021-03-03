# frozen_string_literal: true

class Schema < GraphQL::Schema
  subscription Types::Subscriptions
  mutation Types::Mutations
  query Types::Queries

  # max_complexity 100
  # max_depth 3

  use GraphQL::Backtrace
  use GraphQL::Batch

  use GraphQL::Subscriptions::ActionCableSubscriptions, redis: Redis.new

  # query_analyzer Analyzers::QueryComplexity
  # query_analyzer Analyzers::QueryDepth
end
