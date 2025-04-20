class AddressSerializer < ActiveModel::Serializer
  attributes :id, :street, :city, :state, :zip_code, :country, :is_default, :created_at, :updated_at
end 