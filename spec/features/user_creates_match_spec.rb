require 'rails_helper'

feature "user creates a match" do
  scenario do
    visit new_match_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  scenario "a signed in user can create a match but has to wait for oppenent to join" do
    clear_users
    clear_matches
    FactoryGirl.create(:user, username: 'Tiger')
    FactoryGirl.create(:user, username: 'Phil')
    visit new_user_session_path
    fill_in 'Username/Email', with: 'Tiger'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
    clear_courses
    Course.create(
      name: "Pacific Dunes",
      address: "123 Fairway Drive",
      city: "Bandon",
      state: "OR",
      zip: 97411,
    )
    click_link "New Match"
    select('Phil', from: 'match[villain_id]')
    select('Pacific Dunes', from: 'match[course_id]')
    click_button 'Create Match'

    expect(page).to have_content('Match created. Play well.')
    expect(page).to have_content("Waiting on opponent to join...")
    expect(page).to have_content('Tiger')
    expect(page).to_not have_content('Phil')
  end
end
