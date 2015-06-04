require 'rails_helper'

RSpec.describe User, type: :model do
  context 'class' do
    subject { User }

    #-- Scopes
    it { is_expected.to respond_to :administrators }
    it { is_expected.to respond_to :users }
    it { is_expected.to respond_to :active }
    it { is_expected.to respond_to :leaders }
  end

  context 'object' do
    subject { build :competitor }

    # Is the factory configured correctly?
    it { is_expected.to be_valid }

    #-- Relationships
    it { is_expected.to respond_to :memberships }
    it { is_expected.to respond_to :competitions }
    it { is_expected.to respond_to :catches }
    #-- Devise database authenticatable
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :encrypted_password }
    it { is_expected.to respond_to :reset_password_token }
    it { is_expected.to respond_to :reset_password_sent_at }
    #---- Devise rememberable
    it { is_expected.to respond_to :remember_created_at }
    #---- Devise trackable
    it { is_expected.to respond_to :sign_in_count }
    it { is_expected.to respond_to :current_sign_in_at }
    it { is_expected.to respond_to :last_sign_in_at }
    it { is_expected.to respond_to :current_sign_in_ip }
    it { is_expected.to respond_to :last_sign_in_ip }
    #---- Devise confirmable
    it { is_expected.to respond_to :confirmation_token }
    it { is_expected.to respond_to :confirmed_at }
    it { is_expected.to respond_to :confirmation_sent_at }
    it { is_expected.to respond_to :unconfirmed_email }
    #---- Devise invitable
    it { is_expected.to respond_to :invitation_token }
    it { is_expected.to respond_to :invitation_created_at }
    it { is_expected.to respond_to :invitation_sent_at }
    it { is_expected.to respond_to :invitation_accepted_at }
    it { is_expected.to respond_to :invitation_limit }
    it { is_expected.to respond_to :invited_by_id }
    it { is_expected.to respond_to :invited_by_type }
    it { is_expected.to respond_to :invitations_count }
    #-- Fish species leaderboard attributes
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :role }
    it { is_expected.to respond_to :is_active }
    it { is_expected.to respond_to :reason }
    #-- Counter cache
    it { is_expected.to respond_to :memberships_count }
    it { is_expected.to respond_to :catches_count }
    #-- Timestamps
    it { is_expected.to respond_to :created_at }
    it { is_expected.to respond_to :updated_at }

    #-- Test default values --
    specify { expect(subject.is_active).to eq true }
    specify { expect(subject.reason).to eq '' }

    it 'only supports the roles "administrator" or "user"' do
      subject.role = 'bananas'
      is_expected.to_not be_valid
    end

    it 'allows multiple records to have identical names' do
      first_user = create :competitor
      second_user = build :competitor
      second_user.email = 'rickymartin@aol.com'
      expect(second_user).to be_valid
    end
  end
end
