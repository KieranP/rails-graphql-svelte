# frozen_string_literal: true

module ObjectHelpers
  extend ActiveSupport::Concern

  class_methods do
    def model
      Thread.current["#{name}.model"] ||=
        name.demodulize.constantize
    end

    def association(association, ...)
      field(association, ...)

      define_method(association) do
        Loaders::Association.for(self.class.model, association).load(object)
      end
    end
  end
end
