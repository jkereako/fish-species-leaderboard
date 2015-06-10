require 'rails_helper'

describe InvitationPolicy do
  let (:user) { build :regular_user }
  let (:administrator) { build :admin }

  subject { described_class }

  permissions :create? do
    it { is_expected.to permit administrator }
    it { is_expected.not_to permit user }
  end

  permissions :update? do
    it { is_expected.to permit administrator }
    it { is_expected.to permit user }
  end
end
