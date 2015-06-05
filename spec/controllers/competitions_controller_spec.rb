require 'rails_helper'

RSpec.describe CompetitionsController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when not logged in' do
      it { is_expected.to render_template :index }
    end
  end #index

  describe '#show' do
    let(:competition) { create :competition }

    subject { get :show, id: competition.id }

    context 'when not logged in' do
      it { is_expected.to render_template :show }
    end
  end #show

  describe '#new' do
    subject { get :new }

    context 'when not logged in' do
      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'when logged in' do
      context 'as an administrator' do
        before :each do
          @user = create :admin
          sign_in @user
        end

        it { is_expected.to render_template :new }
      end

      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
        end

        it { is_expected.to redirect_to root_path }
      end
    end
  end #new

  describe '#edit' do
    let(:competition) { create :competition }

    subject { get :edit, id: competition.id }

    context 'when not logged in' do
      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'when logged in' do
      context 'as an administrator' do
        before :each do
          @user = create :admin
          sign_in @user
        end

        it { is_expected.to render_template :edit }
      end

      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
        end

        it { is_expected.to redirect_to root_path }
      end
    end
  end #edit
end
