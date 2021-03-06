require 'rails_helper'

RSpec.describe Catch, type: :model do
  context 'class' do
    subject { Catch }
    #-- Scopes
    it { is_expected.to respond_to :recent }
    it { is_expected.to respond_to :top_10 }
    it { is_expected.to respond_to :for_competition }
  end

  context 'object' do
    subject { build :catch }

    #-- FactoryGirl
    it { is_expected.to be_valid }
    #-- Relationships
    it { is_expected.to respond_to :competition }
    it { is_expected.to respond_to :user }
    #-- Helpers
    it { is_expected.to respond_to :image }
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
    #-- Test default values --
    specify { expect(subject.length_in_inches).to eq 0 }
    specify { expect(subject.was_released).to eq true }

    ##-- Test validations
    context 'invalidates' do
      context 'caught_at' do
        it 'with future date' do
          subject.caught_at = Time.zone.now + 100.years
          expect(subject).to_not be_valid
        end

        it 'with invalid date string' do
          subject.caught_at = "Where's the beef?!"
          expect(subject).to_not be_valid
        end

        it 'with nil' do
          subject.caught_at = nil
          expect(subject).to_not be_valid
        end
      end
      context 'length_in_inches' do
        #-- length_in_inches
        it 'with strings' do
          subject.length_in_inches = '$3 bill!'
          expect(subject).to_not be_valid
        end

        it 'with negative integers' do
          subject.length_in_inches = -36
          expect(subject).to_not be_valid
        end
      end

      #-- bait_used
      it 'nil for "bait_used"' do
        subject.bait_used = nil
        expect(subject).to_not be_valid
      end
      #-- location_description
      it 'nil for "location_description"' do
        subject.bait_used = nil
        expect(subject).to_not be_valid
      end
      #-- image
      it 'nil for "image"' do
        subject.image = nil
        expect(subject).to_not be_valid
      end
    end
  end
end
