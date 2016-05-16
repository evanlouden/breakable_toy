require 'rails_helper'

RSpec.describe Hole, type: :model do
  it { should have_valid(:hole_number).when(2, 18) }
  it { should_not have_valid(:hole_number).when(nil, 20) }

  it { should have_valid(:difficulty).when(3, 17) }
  it { should_not have_valid(:difficulty).when(nil, 21) }

  it { should have_valid(:par).when(3, 5) }
  it { should_not have_valid(:par).when(nil, 7) }
end
