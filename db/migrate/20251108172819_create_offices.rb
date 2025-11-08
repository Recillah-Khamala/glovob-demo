class CreateOffices < ActiveRecord::Migration[8.0]
  def change
    create_table :offices do |t|
      t.timestamps
    end
  end
end
