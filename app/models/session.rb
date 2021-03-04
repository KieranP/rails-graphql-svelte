# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id             :bigint           not null, primary key
#  expires_at     :datetime
#  last_access_at :datetime
#  uuid           :uuid             not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  jwt_id         :string           not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#  index_sessions_on_uuid     (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Session < ApplicationRecord
  include HasUuid

  belongs_to :user

  before_validation :populate_jwt_id
  before_validation :populate_expiration

  validates :jwt_id, presence: true
  validates :expires_at, presence: true

  def mark_visit!
    # rubocop:disable Rails/SkipsModelValidations
    update_column(:last_access_at, Time.zone.now)
    # rubocop:enable Rails/SkipsModelValidations
  end

  private

  def populate_jwt_id
    self.jwt_id ||= SecureRandom.uuid
  end

  def populate_expiration
    self.expires_at ||= 1.month.from_now
  end
end
