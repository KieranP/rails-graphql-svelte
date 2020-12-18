module Analyzers
  class QueryDepth < GraphQL::Analysis::AST::QueryDepth
    def result
      query_depth = super
      message = "[GraphQL Query Depth] #{query_depth}"
      Rails.logger.info(message)
    end
  end
end
