FactoryBot.define do
  factory :garden do
    name { Faker::Name.last_name << " Garden" }
    organic { [true, false].sample }
  end
end
