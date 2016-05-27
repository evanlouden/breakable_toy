require 'rails_helper'

feature "user searches for a course" do
  scenario 'user signs in and successfully searches for a course' do
    course = FactoryGirl.create(:course, name: "Oakmont")
    20.times do
      FactoryGirl.create(:course)
    end
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Username/Email', with: user.username
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'View Courses'
    fill_in 'query', with: course.name
    click_button 'Search'
    expect(page).to have_content course.name
  end

  scenario 'an unauthorized user cannot search for a course' do
    visit courses_path
    fill_in('query', with: "Shinnecock Hills")
    click_button 'Search'

    expect(page).to have_content("Please sign in or sign up to continue.")
    expect(page).to_not have_content("Shinnecock Hills")
  end
end
