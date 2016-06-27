require 'rails_helper'

feature 'user can edit account information' do
  scenario 'an existing user signs and can view edit account page' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Username/Email", with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Edit Account'

    expect(page).to have_field('user[email]', with: user.email)
    expect(page).to have_field('user[handicap]', with: user.handicap)
    end

  scenario 'an existing user signs and can edit account' do
    user1 = FactoryGirl.create(:user, handicap: 10)
    visit root_path
    click_link "Sign In"
    fill_in "Username/Email", with: user1.email
    fill_in 'Password', with: user1.password
    click_button 'Sign In'
    click_link 'Edit Account'
    fill_in 'Handicap', with: '5'
    fill_in 'Current password', with: user1.password
    click_on 'Update Account'

    expect(page).to have_content "Your account has been updated successfully."
    expect(page).to have_content "#{user1.username} - 5"
    end
  end
