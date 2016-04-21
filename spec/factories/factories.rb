FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "tiger#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    handicap [1, 6, 10, 18, 25].sample
  end
end

FactoryGirl.define do
  Course.create(
    name: "Pacifc Dunes",
    address: "123 Fairway Drive",
    city: "Bandon",
    state: "OR",
    zip: 97411,
  )
end
