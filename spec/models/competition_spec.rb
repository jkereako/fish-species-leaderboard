require 'rails_helper'

RSpec.describe Competition, type: :model do
  context 'class' do
    subject { Competition }
    #-- Scopes
    it { is_expected.to respond_to :begun }
    it { is_expected.to respond_to :expired }
    it { is_expected.to respond_to :suspended }
    it { is_expected.to respond_to :yet_to_begin }
  end

  context 'object' do
    let(:competition) { build :competition }

    subject { competition }

    # Is the factory configured correctly?
    it { is_expected.to be_valid }
    #-- Relationships
    it { is_expected.to respond_to :winner }
    it { is_expected.to respond_to :memberships }
    it { is_expected.to respond_to :users }
    it { is_expected.to respond_to :catches }
    #-- Fish species leaderboard attributes
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :prize }
    it { is_expected.to respond_to :begins_at }
    it { is_expected.to respond_to :ends_at }
    it { is_expected.to respond_to :has_expired }
    it { is_expected.to respond_to :is_suspended }
    #-- Counter cache
    it { is_expected.to respond_to :winner_catches_count }
    it { is_expected.to respond_to :memberships_count }
    it { is_expected.to respond_to :catches_count }
    #-- Timestamps
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }
  end
end
