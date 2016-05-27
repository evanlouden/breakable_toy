require 'rails_helper'

feature 'user can enter a holescore' do
  scenario "two users create a match and one user enters a score and then updates it" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    course = FactoryGirl.create(:course)
    Match.create(hero: user1, villain: user2, hero_adj_handicap: 0, villain_adj_handicap: 5, course: course)
    5.times do |n|
      Hole.create(hole_number: n + 1, difficulty: n + 1, course: course, par: 4)
    end

    visit root_path
    click_link 'Sign In'
    fill_in "Username/Email", with: user1.username
    fill_in "Password", with: user1.password
    click_button 'Sign In'
    click_link 'Sign Out'

    click_link 'Sign In'
    fill_in "Username/Email", with: user2.username
    fill_in "Password", with: user2.password
    click_button 'Sign In'

    click_on '1'
    select '5', from: 'holescore_gross_score'
    click_on 'Enter Score'

    select '6', from: 'holescore_gross_score'
    click_on 'Update Score'

    within("//div[@id='user_gross_score']") do
      expect(page).to have_content '6'
    end
  end
end
