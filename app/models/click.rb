# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url
  validates :url_id, presence: true
  validates :browser, presence: true
  validates :platform, presence: true

  # scopes:
  scope :daily_clicks, -> { group('created_at').count.map { |key, value| [key.strftime('%d'), value] }  } 
  scope :browsers_clicks, -> { group('browser').count.to_a }
  scope :platform_clicks, -> { group('platform').count.to_a }

end
