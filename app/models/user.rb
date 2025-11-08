class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, length: { minimum: 10, maximum: 20 }
  validates :address, presence: true, length: { minimum: 10, maximum: 500 }
end

