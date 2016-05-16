require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_valid(:name).when('Bandon Dunes', 'Oakmont') }
  it { should_not have_valid(:name).when(nil) }

  it { should have_valid(:address).when('1 Park Ave', '20 Main Street') }
  it { should_not have_valid(:address).when(nil) }

  it { should have_valid(:city).when('Boston', 'Chicago') }
  it { should_not have_valid(:city).when(nil) }

  it { should have_valid(:state).when('AK', 'NM') }
  it { should_not have_valid(:state).when(nil, '40') }

  it { should have_valid(:zip).when('12345') }
  it { should_not have_valid(:zip).when(nil) }
end
