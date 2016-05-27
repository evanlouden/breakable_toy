require 'rails_helper'

feature 'update hole information' do
  scenario "a user can update hole information" do
    user1 = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    Hole.create(hole_number: 1, difficulty: 1, course: course, par: 4)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    click_link 'View Courses'
    click_link course.name
    click_link 'Edit'

    fill_in 'Par', with: 5
    click_on 'Update Hole'

    within("//div[@id='hole-info']") do
      expect(page).to have_content 5
    end
  end

  scenario "a user receives error for trying to update with incorrect info" do
    user2 = FactoryGirl.create(:user)
    course1 = FactoryGirl.create(:course)
    Hole.create(hole_number: 1, difficulty: 1, course: course1, par: 4)

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user2.username
    fill_in "Password", with: user2.password
    click_button 'Sign In'
    click_link 'View Courses'
    click_link course1.name
    click_link 'Edit'

    fill_in 'Hole', with: 19
    fill_in 'Par', with: 7
    fill_in 'Difficulty', with: 20
    click_on 'Update Hole'

    expect(page).to have_content 'Hole number is not included in the list, Difficulty is not included in the list, Par is not included in the list'
  end
end
