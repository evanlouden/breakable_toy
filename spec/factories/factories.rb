FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "tiger#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    handicap [1, 6, 10, 18, 25].sample
  end

  factory :course do
    sequence(:name) { |n| "Pine Hills #{n}" }
    address "123 Main Street"
    city 'Anytown'
    state 'MA'
    zip '12345'
  end

  factory :hole do
    sequence(:hole_number) { |n| n }
    par 4
    sequence(:difficulty) { |n| n }
  end
end
