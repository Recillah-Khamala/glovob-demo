class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.decimal :rating, precision: 2, scale: 1
      t.string :delivery_time
      t.string :price_range
      t.string :categories, array: true, default: []
      t.timestamps
    end
  end
end 