# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

handicaps = [4, 6, 10, 16, 22]
course_first_name = ["Pine", "Oak", "Aspen", "Maple", "Cedar"]
course_last_name = ["Hills", "Valley", "Farms"]

5.times do
  FactoryGirl.create(:user, handicap: handicaps.pop)
end

5.times do
  course = Course.create(
    name: "#{course_first_name.sample} #{course_last_name.sample} Country Club",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip: Faker::Address.zip_code,
  )

  difficulties = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
  pars = [3, 3, 3, 3, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
  18.times do |n|
    pars.shuffle!
    difficulties.shuffle!
    Hole.create!(
      hole_number: n + 1,
      par: pars.pop,
      difficulty: difficulties.pop,
      course: course
    )
  end
end
