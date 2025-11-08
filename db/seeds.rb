# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
Order.destroy_all
User.destroy_all
Office.destroy_all

# Create 5 offices (representing transport companies)
offices = [
  {
    name: "FastTrack Express",
    location: "123 Main Street, Downtown, City Center",
    contact_info: "Phone: +1-555-0101, Email: info@fasttrack.com, Hours: Mon-Fri 9AM-6PM"
  },
  {
    name: "Swift Delivery Services",
    location: "456 Commerce Boulevard, Business District",
    contact_info: "Phone: +1-555-0102, Email: contact@swiftdelivery.com, Hours: Mon-Sat 8AM-7PM"
  },
  {
    name: "Reliable Logistics Co.",
    location: "789 Industrial Avenue, Warehouse Zone",
    contact_info: "Phone: +1-555-0103, Email: support@reliablelogistics.com, Hours: 24/7"
  },
  {
    name: "Metro Courier Solutions",
    location: "321 Transit Road, Metro Area",
    contact_info: "Phone: +1-555-0104, Email: hello@metrocourier.com, Hours: Mon-Fri 7AM-8PM"
  },
  {
    name: "Global Transport Hub",
    location: "654 International Drive, Port District",
    contact_info: "Phone: +1-555-0105, Email: info@globaltransport.com, Hours: Mon-Sun 6AM-10PM"
  }
]

created_offices = offices.map do |office_data|
  Office.create!(office_data)
end

puts "Created #{created_offices.count} offices"

# Create 2 users
users = [
  {
    name: "John Doe",
    email: "john.doe@example.com",
    phone: "+1-555-1001",
    address: "100 Residential Street, Apartment 5B, Suburbia, State 12345"
  },
  {
    name: "Jane Smith",
    email: "jane.smith@example.com",
    phone: "+1-555-1002",
    address: "200 Oak Avenue, House 12, Riverside, State 67890"
  }
]

created_users = users.map do |user_data|
  User.create!(user_data)
end

puts "Created #{created_users.count} users"

# Create 10 sample orders with varying statuses
order_statuses = [:pending, :picked, :in_transit, :delivered]
order_descriptions = [
  "Electronics package - Laptop and accessories",
  "Furniture delivery - Office chair and desk",
  "Clothing order - Winter collection items",
  "Food delivery - Grocery items and beverages",
  "Documents package - Legal papers and contracts",
  "Medical supplies - Prescription medications",
  "Books and stationery - Educational materials",
  "Home appliances - Kitchen equipment",
  "Sports equipment - Gym gear and accessories",
  "Gift package - Birthday presents and decorations"
]

10.times do |i|
  Order.create!(
    user: created_users.sample,
    office: created_offices.sample,
    package_description: order_descriptions[i],
    weight: rand(0.5..50.0).round(2),
    delivery_address: "#{rand(100..999)} Delivery Street, City #{rand(10000..99999)}",
    status: order_statuses.sample,
    estimated_cost: rand(10.0..200.0).round(2),
    estimated_time: rand(30..480) # minutes (30 minutes to 8 hours)
  )
end

puts "Created 10 sample orders"

puts "\nSeeding completed successfully!"
puts "Summary:"
puts "- Offices: #{Office.count}"
puts "- Users: #{User.count}"
puts "- Orders: #{Order.count}"
