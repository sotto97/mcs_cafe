FactoryBot.define do
  factory :notice do
    body { Faker::Lorem.characters(number:20) }
    username { Faker::Lorem.characters(number:5) }
    user
  end
end