FactoryGirl.define do
  factory :log do
    note { Faker::Lorem.word }
    work_id nil
  end
end