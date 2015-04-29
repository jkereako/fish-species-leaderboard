class UsersController < ApplicationController
  def index
    authorize :user

    @users = User.all
  end

  def show
    authorize :user

    @user = current_user
  end
end
