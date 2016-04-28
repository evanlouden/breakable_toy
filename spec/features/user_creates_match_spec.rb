require 'rails_helper'

feature "user creates a match" do
  Course.create(
  name: "Pebble Beach",
  address: "1 Cypress Drive",
  city: "Monterey",
  state: "CA",
  zip: 12345,
  )
  scenario do
    visit new_match_path

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  scenario "a signed in user can create a match but has to wait for oppenent to join", js: true do
    clear_users
    visit root_path
    find('#hamburger').click
    click_on 'Sign Up'
    fill_in 'Username', with: 'jordan'
    fill_in 'Email', with: 'joran@ua.com'
    fill_in 'Handicap', with: 3
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'
    find('#hamburger').click
    click_link 'Sign Out'
    find('#hamburger').click
    click_on 'Sign Up'
    fill_in 'Username', with: 'rickie'
    fill_in 'Email', with: 'rickie@puma.com'
    fill_in 'Handicap', with: 6
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'
    find('#hamburger').click
    click_link "New Match"
    select('jordan', from: 'match[villain_id]')
    select('Pebble Beach', from: 'match[course_id]')
    click_button 'Create Match'

    expect(page).to have_content('Match created. Play well.')
    expect(page).to have_content("Waiting on opponent to join...")
    expect(page).to_not have_content('rickie')
  end
end
