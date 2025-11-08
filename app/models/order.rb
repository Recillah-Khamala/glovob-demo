class Order < ApplicationRecord
  belongs_to :user
  belongs_to :office

  enum status: {
    pending: 0,
    picked: 1,
    in_transit: 2,
    delivered: 3
  }

  validates :package_description, presence: true, length: { minimum: 5, maximum: 1000 }
  validates :weight, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 1000 }
  validates :delivery_address, presence: true, length: { minimum: 10, maximum: 500 }
  validates :status, presence: true
  validates :tracking_code, presence: true, uniqueness: true
  validates :estimated_cost, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :estimated_time, numericality: { greater_than: 0 }, allow_nil: true

  before_validation :generate_tracking_code, on: :create

  private

  def generate_tracking_code
    self.tracking_code ||= "GLV#{SecureRandom.alphanumeric(8).upcase}"
  end
end

