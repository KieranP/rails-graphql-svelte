# frozen_string_literal: true

module Loaders
  class Multi < GraphQL::Batch::Loader
    def initialize(model, column)
      @model = model
      @column = column
    end

    def perform(ids)
      condition = { @column => ids.uniq }
      records = @model.where(condition)

      records_by_relation_id = records.group_by do |result|
        result.public_send(@column)
      end

      ids.each do |id|
        fulfill(id, records_by_relation_id[id] || [])
      end
    end
  end
end
