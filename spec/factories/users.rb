FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
  end
end

