class AddDetailsToAddresses < ActiveRecord::Migration[8.0]
  def change
    add_column :addresses, :building_or_estate_name, :string
    add_column :addresses, :house_number_or_name, :string
  end
end
