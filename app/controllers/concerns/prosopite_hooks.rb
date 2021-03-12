# frozen_string_literal: true

module ProsopiteHooks
  extend ActiveSupport::Concern

  included do
    unless Rails.env.production?
      before_action do
        Prosopite.scan
      end

      after_action do
        Prosopite.finish
      end
    end
  end
end
