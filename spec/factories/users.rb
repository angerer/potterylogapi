FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.first_name }
    password { Faker::Lorem.word }
    password_confirmation { "#{password}" }
    email { "#{firstname}.#{lastname}@example.com".downcase }
  end
end