require 'rails_helper'

feature 'strokes are applied correctly' do
  scenario "two users create a match and the lower users handicap is adjusted to zero and the higher to the difference" do
    user1 = FactoryGirl.create(:user, handicap: 1)
    user2 = FactoryGirl.create(:user, handicap: 3)
    course = FactoryGirl.create(:course)
    Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)
    Hole.create(hole_number: 2, difficulty: 18, course: course, par: 4)

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
    within("//div[@id='user_hole_strokes']") do
      expect(page).to have_content '1'
    end

    click_on 'Match Home'
    click_on '2'

    within("//div[@id='user_hole_strokes']") do
      expect(page).to_not have_content '1'
    end
  end

  scenario "two users create a match and the lower users handicap is adjusted to zero and the higher to the difference" do
    user1 = FactoryGirl.create(:user, handicap: 1)
    user2 = FactoryGirl.create(:user, handicap: 20)
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
    within("//div[@id='user_hole_strokes']") do
      expect(page).to have_content '2'
    end
  end

  scenario "two users create a match and the lower users handicap is adjusted to zero and the higher to the difference" do
    user1 = FactoryGirl.create(:user, handicap: 10)
    user2 = FactoryGirl.create(:user, handicap: 20)
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
    within("//div[@id='user_hole_strokes']") do
      expect(page).to have_content '1'
    end
  end
end
