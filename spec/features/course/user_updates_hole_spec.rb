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
end
