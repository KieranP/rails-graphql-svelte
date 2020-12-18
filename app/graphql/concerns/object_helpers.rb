module ObjectHelpers
  extend ActiveSupport::Concern

  class_methods do
    def model
      @model ||= self.name.demodulize.constantize
    end

    def association(association, *fields)
      field association, *fields

      define_method(association) do
        Loaders::Association.for(self.class.model, association).load(object)
      end
    end
  end
end
