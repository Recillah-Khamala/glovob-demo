class Address < ApplicationRecord
  belongs_to :user

  # Validations
  validates :street, presence: true, length: { minimum: 3, maximum: 100 }
  validates :city, presence: true, length: { minimum: 2, maximum: 50 }
  validates :state, presence: true, length: { minimum: 2, maximum: 50 }
  validates :postal_code, presence: true, length: { minimum: 3, maximum: 10 }
  validates :country, presence: true, length: { minimum: 2, maximum: 50 }
  validates :building_or_estate_name, length: { maximum: 100 }, allow_blank: true
  validates :house_number_or_name, length: { maximum: 50 }, allow_blank: true
end
