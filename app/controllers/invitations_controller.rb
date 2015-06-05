class InvitationsController < Devise::InvitationsController
  before_action :authorize_invitation, except: [:show]
  before_action :set_params, only: 'update'
  before_action :set_sanitized_params, only: 'update'

  # See: https://github.com/scambra/devise_invitable/wiki/How-To:-Allow-updating-additional-attributes-when-accepting-invitation
  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class,
                                                         :invitation_token, update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update_attributes update_resource_params.except(:invitation_token)
      end
      format.html do
        super
      end
    end
  end

  private

  def authorize_invitation
    authorize :invitation
  end

  #-- Helpers

  def user_params
    params.require(:user).permit(:name, :role,:invitation_token, :password,
                                 :password_confirmation)
  end

  #-- Callbacks
  # REVIEW: This hack sets the default role to the user. Ideally, this is set
  # via block or method call, but in order to keep Devise Invitations happy,
  # It's best (and easiest) to pass the value through the parameter array
  def set_params
    user_params[:role] = User.user_role
  end

  def set_sanitized_params
    devise_parameter_sanitizer.for :accept_invitation do |u|
      u.permit :name, :role,
               :invitation_token, :password, :password_confirmation
    end
  end
end
