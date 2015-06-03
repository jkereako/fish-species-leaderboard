require 'rails_helper'

RSpec.describe Catch, type: :model do
  let(:a_catch) { create :catch }

  subject { a_catch }

  # Is the factory configured correctly?
  it { is_expected.to be_valid }

  #-- Relationships
  it { is_expected.to respond_to :competition }
  it { is_expected.to respond_to :user }
  #-- Fish species leaderboard attributes
  it { is_expected.to respond_to :species }
  it { is_expected.to respond_to :length_in_inches }
  it { is_expected.to respond_to :bait_used }
  it { is_expected.to respond_to :location_description }
  it { is_expected.to respond_to :was_released }
  it { is_expected.to respond_to :caught_at }
  #-- Paperclip
  it { is_expected.to respond_to :image_file_name }
  it { is_expected.to respond_to :image_content_type }
  it { is_expected.to respond_to :image_file_size }
  it { is_expected.to respond_to :image_updated_at }
  #-- Timestamps
  it { is_expected.to respond_to :created_at }
  it { is_expected.to respond_to :updated_at }
end
