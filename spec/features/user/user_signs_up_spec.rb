require 'rails_helper'

feature 'sign up' do
  scenario 'specifying valid and required information' do
    visit root_path

    click_link 'Sign Up'
    fill_in 'Username', with: 'Jack'
    fill_in 'Email', with: 'nicklaus@example.com'
    fill_in 'Handicap', with: 10
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'
    click_button 'Sign Up'

    expect(page).to have_content("Thanks for joining us!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'required information is not supllied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation does not match password' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'notPassword'

    click_button 'Sign Up'
    expect(page).to have_content("doesn't match")
    expect(page).to have_content("Sign Up")
  end

  scenario 'user enters an invalid handicap number' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'Email', with: 'user@example.com'
    fill_in 'Handicap', with: 50
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    click_button 'Sign Up'
    expect(page).to have_content("Handicap must be less than or equal to 36")
    expect(page).to have_content("Sign Up")
  end
end
