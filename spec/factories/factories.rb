FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "tiger#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    handicap [1, 6, 10, 18, 25].sample
  end
end
