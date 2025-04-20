class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :image_url, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :delivery_time, presence: true
  validates :price_range, presence: true
end 