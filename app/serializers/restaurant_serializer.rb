class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :rating, :delivery_time, :price_range, :categories, :created_at, :updated_at
end 