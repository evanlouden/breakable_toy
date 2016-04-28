require 'rails_helper'

feature "see courses" do
  scenario "an unauthorized user sees a list of created courses" do
    course = Course.create(
      name: "Bandon Dunes",
      address: "1 Golf Place",
      city: "Bandon",
      state: "OR",
      zip: "97214",
    )

    visit root_path
    click_link 'Courses'
    expect(page).to have_content(course.name)
  end
end
