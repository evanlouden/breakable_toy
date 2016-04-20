require 'rails_helper'

feature 'user signs in' do
  scenario 'an existing user specifies a valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Username/Email", with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("Welcome back!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'an existing user specifies a valid username and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Username/Email", with: user.username
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content("Welcome back!")
    expect(page).to have_content("Sign Out")
  end

  scenario 'a nonexistent email and password is given' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Username/Email', with: 'noemail@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Invalid login or password')
    expect(page).to_not have_content('Welcome back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an existing email with the wrong password is denied access' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in 'Username/Email', with: user.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Sign In'

    expect(page).to have_content('Invalid login or password')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
  end
end
