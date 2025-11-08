class CreateOffices < ActiveRecord::Migration[8.0]
  def change
    create_table :offices do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :contact_info, null: false

      t.timestamps
    end
  end
end
