require 'rails_helper'

feature 'round scores calculate correctly' do
  scenario 'a signed in user with a handicap 9 or less can see past round scores adjusted for esc' do
    user1 = FactoryGirl.create(:user, handicap: 1)
    user2 = FactoryGirl.create(:user, handicap: 1)
    course = FactoryGirl.create(:course)
    hole1 = Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    hole2 = Hole.create(hole_number: 2, difficulty: 2, course: course, par: 4)
    match = Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 0, course: course)
    Holescore.create(gross_score: 10, net_score: 10, user: user1, hole: hole1, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole1, match: match)
    Holescore.create(gross_score: 4, net_score: 4, user: user1, hole: hole2, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole2, match: match)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    visit "/users/#{user1.id}/scores"

    expect(page).to have_content "Gross score: 14"
    expect(page).to have_content "ESC score: 10"
  end

  scenario 'a signed in user with a handicap between 10 and 19 can see past round scores adjusted for esc' do
    user1 = FactoryGirl.create(:user, handicap: 11)
    user2 = FactoryGirl.create(:user, handicap: 1)
    course = FactoryGirl.create(:course)
    hole1 = Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    hole2 = Hole.create(hole_number: 2, difficulty: 2, course: course, par: 4)
    match = Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 0, course: course)
    Holescore.create(gross_score: 10, net_score: 10, user: user1, hole: hole1, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole1, match: match)
    Holescore.create(gross_score: 4, net_score: 4, user: user1, hole: hole2, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole2, match: match)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    visit "/users/#{user1.id}/scores"

    expect(page).to have_content "Gross score: 14"
    expect(page).to have_content "ESC score: 11"
  end

  scenario 'a signed in user with a handicap between 20 and 29 can see past round scores adjusted for esc' do
    user1 = FactoryGirl.create(:user, handicap: 21)
    user2 = FactoryGirl.create(:user, handicap: 1)
    course = FactoryGirl.create(:course)
    hole1 = Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    hole2 = Hole.create(hole_number: 2, difficulty: 2, course: course, par: 4)
    match = Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 0, course: course)
    Holescore.create(gross_score: 10, net_score: 10, user: user1, hole: hole1, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole1, match: match)
    Holescore.create(gross_score: 4, net_score: 4, user: user1, hole: hole2, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole2, match: match)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    visit "/users/#{user1.id}/scores"

    expect(page).to have_content "Gross score: 14"
    expect(page).to have_content "ESC score: 12"
  end

  scenario 'a signed in user with a handicap higher than 29 can see past round scores adjusted for esc' do
    user1 = FactoryGirl.create(:user, handicap: 30)
    user2 = FactoryGirl.create(:user, handicap: 1)
    course = FactoryGirl.create(:course)
    hole1 = Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    hole2 = Hole.create(hole_number: 2, difficulty: 2, course: course, par: 4)
    match = Match.create(hero: user2, villain: user1, hero_adj_handicap: 0, villain_adj_handicap: 0, course: course)
    Holescore.create(gross_score: 10, net_score: 10, user: user1, hole: hole1, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole1, match: match)
    Holescore.create(gross_score: 4, net_score: 4, user: user1, hole: hole2, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole2, match: match)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    visit "/users/#{user1.id}/scores"

    expect(page).to have_content "Gross score: 14"
    expect(page).to have_content "ESC score: 13"
  end
end
