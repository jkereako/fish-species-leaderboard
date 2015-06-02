require 'rails_helper'

RSpec.describe Catch, type: :model do
  let(:a_catch) { create :catch}

  subject { a_catch }

  # Is the factory configured correctly?
  it { is_expected.to be_valid }
end
