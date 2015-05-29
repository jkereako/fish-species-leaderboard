class UsersController < ApplicationController
  before_action :authorize_user, except: 'show'
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # XHR requests only
  def toggle_activation
    if current_user == @user
      render 'shared/error',
              locals: { errors: @user.errors,
              notice: "You can't deactivate yourself." },
              status: :method_not_allowed
    end

   @user.is_active = !@user.active?
   if @user.save
     # TODO: Notify the user that his account has been activated/deactivated
     render :show,
            locals: { competition: @user,
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
