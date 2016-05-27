require 'rails_helper'

feature "create a ghost match" do
  scenario "a signed in user can create a ghost match" do
    #create first database user for ghosting
    FactoryGirl.create(:user, username: 'Ghost')
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    hole = Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    match = Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 5, course: course, match_completed: true)
    Holescore.create(gross_score: 5, net_score: 5, user: user1, hole: hole, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole, match: match)

    visit root_path
    click_on 'Sign In'
    fill_in 'Username/Email', with: user1.username
    fill_in 'Password', with: user1.password
    click_button 'Sign In'
    click_link "New Match"
    click_button 'Create Ghost Match'

    expect(page).to have_content('Opponent: Ghost')
    expect(page).to_not have_content(user2.username)
  end
end
