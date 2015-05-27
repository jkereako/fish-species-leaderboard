class UsersController < ApplicationController
  before_action :authorize_user, except: 'show'
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    if @user.present?
      # Pass the object @user to Pundit to check against @current_user
      authorize @user
    else
      authorize_user
    end
  end

  private
  def authorize_user
    authorize :user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_id params[:id]
  end

  # Never trust parameters from the scary internet, only allow the white lis
  # through.
  def user_params
    params[:user]
  end
end
