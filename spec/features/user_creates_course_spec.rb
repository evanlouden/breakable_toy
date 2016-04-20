require 'rails_helper'

feature "user creates a course" do
  context "user is signed in" do
    before(:each) do
      clear_users
      @user = FactoryGirl.create(:user, username: 'Tiger')
      visit new_user_session_path
      fill_in 'Username/Email', with: 'Tiger'
      fill_in 'Password', with: 'password'
      click_button 'Sign In'
    end

    scenario "after signing in a user creates a course" do
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
    click_link 'Create Course'

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end