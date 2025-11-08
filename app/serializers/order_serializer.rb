class OrderSerializer < ActiveModel::Serializer
  attributes :id, :package_description, :weight, :delivery_address, :status,
             :estimated_cost, :estimated_time, :tracking_code, :created_at, :updated_at

  belongs_to :user
  belongs_to :office
end

