FactoryBot.define do
  factory :news do
    title { Faker::Lorem.characters(number:5) }
    body { Faker::Lorem.characters(number:20) }
    admin
  end
end