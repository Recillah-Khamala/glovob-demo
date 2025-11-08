class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :office, null: false, foreign_key: true
      t.text :package_description, null: false
      t.decimal :weight, precision: 10, scale: 2, null: false
      t.text :delivery_address, null: false
      t.integer :status, default: 0, null: false
      t.decimal :estimated_cost, precision: 10, scale: 2
      t.integer :estimated_time
      t.string :tracking_code, null: false

      t.timestamps
    end

    add_index :orders, :tracking_code, unique: true
    add_index :orders, :status
  end
end
