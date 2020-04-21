FactoryBot.define do
  factory :user do
    first_name { Faker::Lorem.characters(number:2) }
    last_name { Faker::Lorem.characters(number:2) }
    first_name_kana { Faker::Lorem.characters(number:4) }
    last_name_kana { Faker::Lorem.characters(number:4) }
    username { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end