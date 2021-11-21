# frozen_string_literal: true

class Url < ApplicationRecord
  has_many :clicks
  validates :original_url, presence: true, url: true
  validates :short_url, presence: true, uniqueness: true, length: { is: 5 }, format: { with: /[A-Z]/ }
  scope :latest, -> {order(id: :desc).limit(10)}

  # helper function:
  def self.generate_short_url
    (0...5).map { ('A'..'Z').to_a[rand(26)] }.join
  end

end
