FactoryBot.define do
  factory :order do
    association :user
    association :office
    package_description { Faker::Commerce.product_name }
    weight { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    delivery_address { Faker::Address.full_address }
    status { :pending }
    estimated_cost { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    estimated_time { Faker::Number.between(from: 30, to: 480) }
  end
end

