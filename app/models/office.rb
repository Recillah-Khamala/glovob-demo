class Office < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :location, presence: true, length: { minimum: 5, maximum: 200 }
  validates :contact_info, presence: true, length: { minimum: 10, maximum: 500 }
end

