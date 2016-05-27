require 'rails_helper'

feature 'match status displays correctly' do
  scenario "two users create a match and the match status displays correctly" do
    user1 = FactoryGirl.create(:user, handicap: 1)
    user2 = FactoryGirl.create(:user, handicap: 1)
    course = FactoryGirl.create(:course)
    Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)

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
    click_on '1'
    select '5', from: 'holescore_gross_score'
    click_on 'Enter Score'
    click_link 'Sign Out'

    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    click_on '1'
    select '4', from: 'holescore_gross_score'
    click_on 'Enter Score'

    expect(page).to have_content '1 UP'
    expect(page).to_not have_content 'All Square'
  end
end
