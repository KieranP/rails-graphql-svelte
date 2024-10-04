# frozen_string_literal: true

module Loaders
  class Single < GraphQL::Batch::Loader
    def initialize(model, column)
      super
      @model = model
      @column = column
    end

    def perform(ids)
      condition = { @column => ids.uniq }
      records = @model.where(condition)

      records.each do |record|
        id = record.public_send(@column)
        fulfill(id, record)
      end

      ids.each do |id|
        fulfill(id, nil) unless fulfilled?(id)
      end
    end
  end
end
