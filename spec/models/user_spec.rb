require 'rails_helper'

RSpec.describe User, type: :model do
  let(:regular_user) { build :regular_user}

  subject { regular_user }

  # Is the factory configured correctly?
  it { is_expected.to be_valid }

  # Test default values
  it 'is active on default' do
    expect(regular_user.is_active).to eq true
  end

  it 'only supports the roles "administrator" or "user"' do
    regular_user.role = 'bananas'
    is_expected.to_not be_valid
  end

  it 'allows multiple records to have identical names' do
    first_user = create :regular_user
    second_user = build :regular_user
    second_user.email = 'rickymartin@aol.com'
    expect(second_user).to be_valid
  end

end
