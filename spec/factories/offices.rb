FactoryBot.define do
  factory :office do
    name { Faker::Company.name }
    location { Faker::Address.full_address }
    contact_info { "Phone: #{Faker::PhoneNumber.phone_number}, Email: #{Faker::Internet.email}, Hours: Mon-Fri 9AM-6PM" }
  end
end

