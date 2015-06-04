require 'rails_helper'

describe UserPolicy do
  subject { described_class }

  let (:first_user) { build :regular_user }
  let (:second_user) { build :regular_user }
  let (:administrator) { build :admin }

  permissions :index? do
    it { is_expected.to permit administrator }
    it { is_expected.not_to permit first_user }
  end

  permissions :show? do
    # Permit a user to see his own profile
    it { is_expected.to permit first_user, first_user }

    # Deny access to user profiles owned by other users
    it { is_expected.not_to permit first_user, second_user }

    it { is_expected.to permit administrator }
  end

  permissions :change_password? do
    it { is_expected.not_to permit first_user, second_user }
    it { is_expected.not_to permit administrator, first_user }
    it { is_expected.to permit first_user, first_user }
  end

  permissions :toggle_activation? do
    it { is_expected.not_to permit first_user, second_user }
    it { is_expected.not_to permit first_user, first_user }
    it { is_expected.to permit administrator, first_user }
  end
end
