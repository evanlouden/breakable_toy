require 'rails_helper'

feature "user creates a course", js: true do
  context "user is signed in" do
    clear_users
    clear_courses
    scenario "after signing in a user creates a course" do
      visit root_path
      find('#hamburger').click
      click_on 'Sign Up'
      fill_in 'Username', with: 'tiger'
      fill_in 'Email', with: 'tiger@nike.com'
      fill_in 'Handicap', with: 3
      fill_in 'Password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign Up'
      click_on 'Create Course'
      fill_in 'Course Name', with: "Pacific Dunes"
      fill_in 'Address', with: '1 Bandon Place'
      fill_in 'City', with: 'Bandon'
      select('Oregon', from: 'State')
      fill_in 'Zip', with: '97245'
      click_on 'Create Course'

      expect(page).to have_content('Pacific Dunes has been added.')
      expect(page).to have_content('1 Bandon Place')
      expect(page).to have_content('Bandon')
      expect(page).to have_content('OR')
      expect(page).to have_content('97245')
    end

    scenario "a user can't create a course without valid information" do
      visit root_path
      find('#hamburger').click
      click_on 'Sign Up'
      fill_in 'Username', with: 'phil'
      fill_in 'Email', with: 'phil@calloway.com'
      fill_in 'Handicap', with: 3
      fill_in 'Password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign Up'
      click_on 'Create Course'
      fill_in 'Course Name', with: "Pacific Dunes"
      fill_in 'Address', with: ''
      fill_in 'City', with: ''
      select('Oregon', from: 'State')
      fill_in 'Zip', with: ''
      click_on 'Create Course'

      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("Zip can't be blank")
      expect(page).to_not have_content("Pacific Dunes")
    end
  end

  scenario "user must login to create a course" do
    visit root_path
    find('#hamburger').click
    click_on 'View Courses'
    click_link 'Create Course'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
