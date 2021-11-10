FactoryBot.define do
  factory :plot do
    number { Faker::Number.number(digits: 2) }
    size { ["Small", "Medium", "Large"].sample }
    direction { ["East", "North", "South", "West"].sample }
    garden
  end
end
