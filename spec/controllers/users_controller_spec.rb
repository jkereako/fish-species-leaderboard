require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET index' do
    subject { get :index }

    context 'when logged in' do
      context 'as an administrator' do
        before :each do
          @user = create :admin
          sign_in @user
        end

        it { is_expected.to render_template :index }
      end

      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
        end

        it { is_expected.to redirect_to root_path }
      end
    end

    context 'when not logged in' do
      it { is_expected.to redirect_to new_user_session_path }
    end
  end # GET index

  describe '#show' do
    let(:other_user) { create :regular_user, email: 'tyrion@casterlyrock.com' }

    subject { get :show, id: other_user.id }

    context 'when logged in' do
      context 'as an administrator' do
        before :each do
          @user = create :admin
          sign_in @user
        end

        it { is_expected.to render_template :show }
      end

      context 'as a user' do
        context 'with an active account' do
          before :each do
            @user = create :regular_user
            sign_in @user
          end
          context 'who is the owner' do
            subject { get :show, id: @user.id }

            it { is_expected.to render_template :show }
          end

          context 'who is not the owner' do
            it { is_expected.to redirect_to root_path }
          end
        end

        context 'with an inactive account' do
          before :each do
            @user = create :regular_user, is_active: false
            sign_in @user
          end
          context 'who is the owner' do
            subject { get :show, id: @user.id }

            it { is_expected.to redirect_to new_user_session_path }
          end

          context 'who is not the owner' do
            it { is_expected.to redirect_to new_user_session_path }
          end
        end
      end
    end
  end # GET index
end
