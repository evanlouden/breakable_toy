require 'rails_helper'

feature 'users handicaps are adjusted correctly for an individual match' do
  scenario "two users create a match and the lower users handicap is adjusted to zero and the higher to the difference" do
    user1 = FactoryGirl.create(:user, handicap: 10)
    user2 = FactoryGirl.create(:user, handicap: 5)
    course = FactoryGirl.create(:course)
    5.times do |n|
      Hole.create(hole_number: n + 1, difficulty: n + 1, course: course, par: 4)
    end

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    click_link 'New Match'
    select user2.username, from: 'match_villain_id'
    click_on 'Create Match'
    click_link 'Sign Out'

    click_link 'Sign In'
    fill_in "Username/Email", with: user2.username
    fill_in "Password", with: user2.password
    click_button 'Sign In'

    expect(page).to have_content "Opponent's adjusted handicap is: 5"
    expect(page).to have_content "Your adjusted handicap is: 0"
  end
end
