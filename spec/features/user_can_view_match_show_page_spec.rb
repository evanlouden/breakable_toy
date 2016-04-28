require 'rails_helper'

feature 'user can see the match show page' do
  scenario "two users can see the show page of a match" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    Match.create(hero: user1, villain: user2, hero_adj_handicap: 5, villain_adj_handicap: 12, course: course)
    18.times do
      FactoryGirl.create(:hole, course: course)
    end

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    click_link "Handicap"
    click_link user2.username
    click_link 'Sign Out'

    click_link 'Sign In'
    fill_in "Username/Email", with: user2.username
    fill_in "Password", with: user2.password
    click_button 'Sign In'
    click_link "Handicap"
    click_link user1.username

    expect(page).to have_content course.name
    expect(page).to have_content "Opponent: #{user1.username}"
  end
end
