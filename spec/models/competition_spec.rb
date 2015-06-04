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
    subject { build :competition }

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

    #-- Helper methods
    #   Make sure they do what they're supposed to.
    context 'helper' do
      context '`active?`' do
        specify { expect(subject.active?).to eq true }

        specify '`active?` with `has_expired` true' do
          subject.has_expired = true
          expect(subject.active?).to eq false
        end
        specify '`active?` with `is_suspended` true' do
          subject.is_suspended = true
          expect(subject.active?).to eq false
        end
        specify '`active?` with future date' do
          subject.begins_at = Time.now.utc + 1.days
          expect(subject.active?).to eq false
        end
      end

      context '`yet_to_begin?`' do
        specify do
          subject.begins_at = Time.now.utc - 1.days
          expect(subject.yet_to_begin?).to eq false
        end
        specify do
          subject.begins_at = Time.now.utc + 1.days
          expect(subject.yet_to_begin?).to eq true
        end
      end

      context '`suspended?`' do
        specify { expect(subject.suspended?).to eq false }

        specify do
          subject.is_suspended = true
          expect(subject.suspended?).to eq true
        end
        specify do
          subject.is_suspended = false
          expect(subject.suspended?).to eq false
        end
      end

      context '`expired?`' do
        specify { expect(subject.expired?).to eq false }

        specify do
          subject.has_expired = true
          expect(subject.expired?).to eq true
        end
        specify do
          subject.has_expired = false
          expect(subject.expired?).to eq false
        end
      end
    end

    context 'validates' do
      context '"begins_at"' do
        # We NEVER want to change the value of `begins_at` for an existing
        # record, but, we also don't want the validation to fail every Time
        # the user updates the competition. Our best line of defense is to
        # validate on "create" only and do not pass changes made to `begins_at`
        # to the ActiveRecord instance.
        it 'for update' do
          subject.begins_at = Time.now.utc.to_date - 1.days
          expect { subject.save }.not_to raise_error
        end
      end
    end

    #-- Test validations
    context 'invalidates' do
      #-- name
      it 'identical values for "name"' do
        other_competition = create :competition
        subject.name = other_competition.name
        expect(subject).not_to be_valid
      end
      #-- prize
      it 'nil for "prize"' do
        subject.prize = nil
        expect(subject).not_to be_valid
      end
      #-- begins_at
      context '"begins_at"' do
        it 'with nil' do
          subject.begins_at = nil
          expect(subject).not_to be_valid
        end
        # Test that `begins_at` is validated on create
        it 'with past date' do
          expect do
            create :competition, begins_at: Time.now.utc.to_date - 1.days
          end
            .to raise_error ActiveRecord::RecordInvalid
        end
      end
      #-- ends_at
      context '"ends_at"' do
        it 'with nil' do
          subject.ends_at = nil
          expect(subject).not_to be_valid
        end
        it 'with date older than "begins_at"' do
          subject.begins_at = Time.now.utc.to_date
          subject.ends_at = Time.now.utc.to_date - 1.days
          expect(subject).not_to be_valid
        end
      end
      context 'competitors (users)' do
        it 'when there are fewer than 2' do
          # Delete the first user
          subject.users.delete subject.users.first
          expect(subject).not_to be_valid
        end
      end
    end
  end
end
