class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :address, :created_at, :updated_at

  has_many :orders
end

