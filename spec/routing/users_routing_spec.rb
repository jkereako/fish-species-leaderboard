require "rails_helper"

# Ensure only XHR requests are allowed
RSpec.describe UsersController, type: :routing do
  describe 'route' do
    context 'users#toggle_activation {:format=>"json"}' do
      subject { put toggle_user_activation_path(1) }

      it { is_expected.not_to be_routable }
    end
  end
end
