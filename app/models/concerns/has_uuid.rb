# frozen_string_literal: true

module HasUuid
  extend ActiveSupport::Concern

  included do
    validates :uuid, uniqueness: true

    before_validation :populate_uuid
  end

  private

  def populate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
