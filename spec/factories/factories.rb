FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "tiger#{n}" }
    sequence(:email) { |n| "user#{n}@test.com" }
    password "password"
    handicap [1, 6, 10, 18, 25].sample
  end
end

FactoryGirl.define do
  course_first_name = ["Pine", "Oak", "Aspen", "Maple"]
  course_last_name = ["Hills", "Valley", "Farms", "Ridge"]
  factory :course do
    name "#{course_first_name.sample} #{course_last_name.sample} Country Club"
    address Faker::Address.street_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip Faker::Address.zip
  end
end
