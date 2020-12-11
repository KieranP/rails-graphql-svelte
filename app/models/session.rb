# == Schema Information
#
# Table name: sessions
#
#  id             :integer          not null, primary key
#  expires_at     :datetime
#  last_access_at :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  jwt_id         :string           not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_sessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Session < ApplicationRecord
  belongs_to :user

  before_validation :populate_jwt_id
  before_validation :populate_expiration

  validates :jwt_id, presence: true
  validates :expires_at, presence: true

  def mark_visit!
    update_column(:last_access_at, Time.zone.now)
  end

  private

  def populate_jwt_id
    self.jwt_id ||= SecureRandom.uuid
  end

  def populate_expiration
    self.expires_at ||= 1.month.from_now
  end
end
