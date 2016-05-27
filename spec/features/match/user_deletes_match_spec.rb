require 'rails_helper'

feature "user deletes a match" do
  scenario "a signed in user can delete a match" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 5, course: course)
    Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)

    visit root_path
    click_on 'Sign In'
    fill_in 'Username/Email', with: user1.username
    fill_in 'Password', with: user1.password
    click_button 'Sign In'

    click_on 'Delete Match'

    expect(page).to_not have_content("Waiting on opponent to join...")
    expect(page).to_not have_content user2.username
  end

  scenario do
    user3 = FactoryGirl.create(:user)
    user4 = FactoryGirl.create(:user)
    course1 = FactoryGirl.create(:course)
    hole = Hole.create(hole_number: 1, difficulty: 1, course: course1, par: 4)
    match = Match.create(hero: user3, villain: user4, hero_adj_handicap: 0, villain_adj_handicap: 5, course: course1)
    Holescore.create(gross_score: 5, net_score: 5, user: user3, hole: hole, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user4, hole: hole, match: match)

    visit root_path
    click_on 'Sign In'
    fill_in 'Username/Email', with: user3.username
    fill_in 'Password', with: user3.password
    click_button 'Sign In'
    click_link 'Finish Match'
    click_on 'Delete Match'

    expect(page).to_not have_content user4.username
  end
end
