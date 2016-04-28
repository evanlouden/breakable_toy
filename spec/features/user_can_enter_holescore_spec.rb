require 'rails_helper'
# 
# feature 'user enters holescore information' do
#   pending ""
#   clear_users
#   clear_matches
#   user1 = FactoryGirl.create(:user)
#   user2 = FactoryGirl.create(:user)
#   course = FactoryGirl.create(:course)
#   match = Match.create(hero: user1, villain: user2, course: course)
#
#   scenario "a signed in user sees the user show page" do
#     visit root_path
#     click_link 'Sign In'
#     fill_in "Username/Email", with: user1.username
#     fill_in "Password", with: user1.password
#     click_button 'Sign In'
#
#     click_link 'Sign Out'
#     click_link 'Sign In'
#     fill_in "Username/Email", with: user2.username
#     fill_in "Password", with: user2.password
#     click_button 'Sign In'
#     click_link user1.username
#     click_link user2.username
#   end
# end
