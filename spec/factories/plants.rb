FactoryBot.define do
  factory :plant do
    name { Faker::Food.vegetables }
    description { Faker::Lorem.sentences(number: 2) }
    days_to_harvest { Faker::Number.number(digits: 2) }
  end
end
