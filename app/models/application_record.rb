# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def generate_unique_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless self.class.exists?(column => self[column])
    end
  end
end
