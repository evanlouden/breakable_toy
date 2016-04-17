# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
hero = User.create(email: "evanlouden@gmail.com", password: "password", handicap: 10)
villain = User.create(email: "mister_jade@hotmail.com", password: "password", handicap: 20)
fresh_pond = Course.create(name: "Fresh Pond", address: "691 Huron Avenue", city: "Cambridge", state: "MA", zip: "02138")
hole1 = Hole.create(hole_number: 1, par: 4, difficulty: 3, course: fresh_pond)
# hole2 = Hole.create(hole_number: 2, par: 4, difficulty: 7, course: fresh_pond)
# hole3 = Hole.create(hole_number: 3, par: 3, difficulty: 15, course: fresh_pond)
# hole4 = Hole.create(hole_number: 4, par: 4, difficulty: 1 course: fresh_pond)
# hole5 = Hole.create(hole_number: 5, par: 5, difficulty: 5, course: fresh_pond)
# hole6 = Hole.create(hole_number: 6, par: 3, difficulty: 9, course: fresh_pond)
# hole7 = Hole.create(hole_number: 7, par: 4, difficulty: 13, course: fresh_pond)
# hole8 = Hole.create(hole_number: 8, par: 3, difficulty: 17 course: fresh_pond)
# hole9 = Hole.create(hole_number: 9, par: 5, difficulty: 11 course: fresh_pond)
Match.create(match_status: 0, hero: hero, villain: villain, course: fresh_pond)
