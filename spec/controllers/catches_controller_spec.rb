require 'rails_helper'

RSpec.describe CatchesController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when not logged in' do
      it { is_expected.to render_template :index }
    end
  end #index

  describe '#show' do
    let(:a_catch) { create :catch }

    subject { get :show, id: a_catch.id }

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
      before :each do
        request.env['HTTP_REFERER'] = 'where_you_come_from'
      end
      # We assume that admins have more rights than users, hence, the test for
      # admins has been removed.
      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
        end

        context 'without an active competition' do
          before :each do
            request.env['HTTP_REFERER'] = 'where_you_come_from'
            @user.competitions = []
          end
          it { is_expected.to redirect_to 'where_you_come_from' }
        end

        context 'with 1 active competition' do
          before :each do
            @user.competitions << create(:competition)
          end

          it { is_expected.to render_template :new }
        end

        context 'with multiple active competitions' do
          before :each do
            @user.competitions << create(:competition)
            @user.competitions << create(:competition)
          end

          it { is_expected.to redirect_to 'where_you_come_from' }
        end
      end
    end
  end #new

  describe '#create' do
    let(:a_catch) { create :catch }

    subject { post :create, catch: a_catch }

    context 'when not logged in' do
      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'when logged in' do
      before :each do
        request.env['HTTP_REFERER'] = 'where_you_come_from'
      end
      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
        end
        context 'and sending unexpected parameters' do
          subject { post :create, bad_param: true }
          it { is_expected.to redirect_to 'where_you_come_from' }
        end
        it { is_expected.to render_template :show }
      end
    end
  end #create

  describe '#update' do
    let(:a_catch) { create :catch }

    subject { put :update, id: a_catch.id }

    context 'when not logged in' do
      it { is_expected.to redirect_to new_user_session_path }
    end
  end #update
end
