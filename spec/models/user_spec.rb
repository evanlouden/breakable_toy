require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_valid(:handicap).when('4', '20') }
  it { should_not have_valid(:handicap).when(nil, '40') }

  it { should have_valid(:email).when('user@example.com', 'another@gmail.com') }
  it { should_not have_valid(:email).when(nil, '', 'another@gmailcom') }

  it 'has a matching password confirmation for password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
