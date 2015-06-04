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
      context 'as an administrator' do
        before :each do
          @user = create :admin
          sign_in @user
        end
        # A catch may only be added if a compeition exists. If it does not, then
        # the user is redirected to the referrer or the root path
        context 'without an active competition' do
          it { is_expected.to redirect_to root_path }
        end

        context 'with an active competition' do
          before :each do
            competition = create :competition
            competition.users << @user
          end

          it { is_expected.to render_template :new }
        end
      end

      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
        end

        context 'without an active competition' do
          it { is_expected.to redirect_to root_path }
        end

        context 'with an active competition' do
          before :each do
            competition = create :competition
            competition.users << @user
          end

          it { is_expected.to render_template :new }
        end
      end
    end
  end #new

  describe '#create' do
    # context 'with bad data' do
    #   subject { post :create, { catch: {no_such_prop: true} } }
    #   it { is_expected.to redirect_to new_user_session_path }
    # end
    let(:a_catch) { create :catch }

    subject { post :create, catch: a_catch }

    context 'when not logged in' do
      it { is_expected.to redirect_to new_user_session_path }
    end

    context 'when logged in' do
      context 'as an administrator' do
        before :each do
          @user = create :admin
          sign_in @user
        end

        it { is_expected.to render_template :show }
      end

      context 'as a user' do
        before :each do
          @user = create :regular_user
          sign_in @user
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
