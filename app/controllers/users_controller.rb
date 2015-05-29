class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :toggle_activation]
  before_action :authorize_all_users, except: [:show, :toggle_activation]
  before_action :authorize_individual_user, except: [:show, :toggle_activation]


  # XHR requests only
  def toggle_activation
   @user.is_active = !@user.active?

   if @user.save
     # TODO: Notify the user that his account has been activated/deactivated
     render :show,
            locals: { user: @user,
                      notice: "Successfully toggled #{@user.name}" },
            location: @user,
            status: :ok
   else
     render 'shared/error',
            locals: { errors: @user.errors,
                      notice: "Unable to toggle user's activation" },
            status: :internal_server_error
   end
 end

  def index
    @users = User.all
  end

  private

  def authorize_all_users
    authorize :user
  end

  def authorize_individual_user
    if @user.present?
      # Pass the object @user to Pundit to check against @current_user
      authorize @user
    else
      authorize_all_users
    end
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
