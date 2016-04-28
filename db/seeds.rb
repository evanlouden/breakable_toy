# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "Ghost", email: "ghost@golf.com", password: 'password', handicap: 15)
User.create(username: "Phil", email: "phil@calloway.com", password: 'password', handicap: 15)
User.create(username: "Jordan", email: "jordan@ua.com", password: 'password', handicap: 6)
User.create(username: "Rory", email: "rory@nike.com", password: 'password', handicap: 2)

cabot = Course.create(name: "Cabot Cliffs", address: "15933 Central Avenue", city: "Inverness", state: "ND", zip: 12345)
Hole.create(hole_number: 1, par: 5, difficulty:	5, course: cabot)
Hole.create(hole_number: 2, par: 4, difficulty:	3, course: cabot)
Hole.create(hole_number: 3, par: 4, difficulty:	11, course: cabot)
Hole.create(hole_number: 4, par: 3, difficulty:	13, course: cabot)
Hole.create(hole_number: 5, par: 4, difficulty:	7, course: cabot)
Hole.create(hole_number: 6, par: 3, difficulty:	15, course: cabot)
Hole.create(hole_number: 7, par: 5, difficulty:	1, course: cabot)
Hole.create(hole_number: 8, par: 5, difficulty:	9, course: cabot)
Hole.create(hole_number: 9, par: 3, difficulty:	18, course: cabot)
Hole.create(hole_number: 10, par:	5, difficulty:	2, course: cabot)
Hole.create(hole_number: 11, par:	4, difficulty:	16, course: cabot)
Hole.create(hole_number: 12, par:	3, difficulty:	6, course: cabot)
Hole.create(hole_number: 13, par:	4, difficulty:	8, course: cabot)
Hole.create(hole_number: 14, par:	3, difficulty:	17, course: cabot)
Hole.create(hole_number: 15, par:	5, difficulty:	4, course: cabot)
Hole.create(hole_number: 16, par:	3, difficulty:	14, course: cabot)
Hole.create(hole_number: 17, par:	4, difficulty:	12, course: cabot)
Hole.create(hole_number: 18, par:	5, difficulty:	10, course: cabot)

Course.create(name: "Pebble Beach", address: "1700 17 Mile Drive", city: "Pebble Beach", state: "CA", zip: 93953)
Course.create(name: 'Pacific Dunes', address: "57744 Round Lake", city: "Bandon", state: "OR", zip: 97411)
Course.create(name: "Chambers Bay", address: "6320 Grandview Dr. W", city: "University Place", state: "WA", zip: 99467)
Course.create(name: "George Wright", address: "420 West Street", city: "Hyde Park", state: "MA", zip: 02136)



# handicaps = [4, 6, 10, 16, 22]
# course_first_name = ["Pine", "Oak", "Aspen", "Maple", "Cedar"]
# course_last_name = ["Hills", "Valley", "Farms"]
#
# 5.times do
#   FactoryGirl.create(:user, handicap: handicaps.pop)
# end
#
# 5.times do
#   course = Course.create(
#     name: "#{course_first_name.sample} #{course_last_name.sample} Country Club",
#     address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     state: Faker::Address.state_abbr,
#     zip: Faker::Address.zip_code,
#   )
#
#   difficulties = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
#   pars = [3, 3, 3, 3, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4]
#   18.times do |n|
#     pars.shuffle!
#     difficulties.shuffle!
#     Hole.create(
#       hole_number: n + 1,
#       par: pars.pop,
#       difficulty: difficulties.pop,
#       course: course
#     )
#   end
# end
