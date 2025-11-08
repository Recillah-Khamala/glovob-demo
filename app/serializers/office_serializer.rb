class OfficeSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :contact_info, :created_at, :updated_at

  has_many :orders
end

