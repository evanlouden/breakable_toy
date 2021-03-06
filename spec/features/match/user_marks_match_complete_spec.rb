require 'rails_helper'

feature 'a match can be marked as completed' do
  scenario "two users create a match and the match is compeleted" do
    user1 = FactoryGirl.create(:user, handicap: 1)
    user2 = FactoryGirl.create(:user, handicap: 1)
    course = FactoryGirl.create(:course)
    hole = Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    match = Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 0, course: course)
    Holescore.create(gross_score: 5, net_score: 5, user: user1, hole: hole, match: match)
    Holescore.create(gross_score: 5, net_score: 5, user: user2, hole: hole, match: match)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    click_link 'Finish Match'

    within("//div[@id='completed-matches']") do
      expect(page).to have_content user2.username
    end
  end
end
