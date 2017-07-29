FactoryGirl.define do
  factory :work do
    project { Faker::Lorem.word }
    status { Faker::Lorem.word }
    general_notes { Faker::Lorem.word }
    surface_notes { Faker::Lorem.word }
    price { Faker::Number.decimal(5,2) }
  end
end