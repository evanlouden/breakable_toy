require 'rails_helper'

feature "user adds a new hole to a course" do
  before(:each) do
    FactoryGirl.create(:user, username: 'Tiger')
    visit new_user_session_path
    fill_in 'Username/Email', with: 'Tiger'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    clear_courses
    @course = create_course
    visit course_path(@course)
  end

  scenario "a signed in user successfully enters a new hole" do
    fill_in('Hole', with: 15)
    fill_in('Par', with: 4)
    fill_in('Difficulty', with: 3)
    click_button 'Add Hole'

    expect(page).to have_content('Hole #15 saved.')
    expect(page).to have_content(15)
  end

  scenario "a signed in user enters a hole number not between 1 and 18" do
    fill_in('Hole', with: 20)
    fill_in('Par', with: 4)
    fill_in('Difficulty', with: 3)
    click_button 'Add Hole'

    expect(page).to have_content('Hole number is not included in the list')
    expect(page).to_not have_content(20)
  end

  scenario "a signed in user enter a par not between 3 and 6" do
    fill_in('Hole', with: 9)
    fill_in('Par', with: 8)
    fill_in('Difficulty', with: 4)
    click_button 'Add Hole'

    expect(page).to have_content('Par is not included in the list')
    expect(page).to_not have_content(8)
  end

  scenario "a signed in user enter a par not between 1 and 18" do
    fill_in('Hole', with: 9)
    fill_in('Par', with: 3)
    fill_in('Difficulty', with: 20)
    click_button 'Add Hole'

    expect(page).to have_content('Difficulty is not included in the list')
    expect(page).to_not have_content(20)
  end
end
