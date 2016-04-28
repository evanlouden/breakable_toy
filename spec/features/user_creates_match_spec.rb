require 'rails_helper'

feature "user creates a match" do
  scenario "a signed in user can create a match but has to wait for oppenent to join" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    course =   Course.create(
      name: "Pebble Beach",
      address: "1 Cypress Drive",
      city: "Monterey",
      state: "CA",
      zip: 12345,
      )

    visit root_path
    click_on 'Sign In'
    fill_in 'Username/Email', with: user1.username
    fill_in 'Password', with: user1.password
    click_button 'Sign In'

    click_link "New Match"
    select(user2.username, from: 'match[villain_id]')
    select(course.name, from: 'match[course_id]')
    click_button 'Create Match'

    expect(page).to have_content('Match created. Play well.')
    expect(page).to have_content("Waiting on opponent to join...")
    expect(page).to_not have_content(user2.username)
  end

  scenario do
    visit new_match_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
