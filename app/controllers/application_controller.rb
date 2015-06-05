class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_client_data
  before_action :user_competing_in_multiple_competitions?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Handle the exception raised by Pundit when a user is unauthorized
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActionController::UnpermittedParameters,
              with: :unpermitted_parameters

  private

  def not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'

    if current_user.nil?
      redirect_to url_for new_user_session_path
    else
      redirect_to url_for root_path
    end
  end

  def parameter_missing
    flash[:alert] = 'Something is wrong. Did you not specify a competition when adding a catch?'

    redirect_to url_for request.referrer
  end

  def unpermitted_parameters
    respond_to do |format|
      format.html do
        flash[:alert] = 'Something is wrong.'
        redirect_to url_for request.referrer
      end
      format.json do
        render 'shared/error',
               locals: { errors: nil,
                         notice: 'Data missing or invalid' },
               status: :unprocessable_entity
      end
    end

    flash[:alert] = 'Something is wrong.'

    redirect_to url_for request.referrer
  end

  def user_competing_in_multiple_competitions?
    return unless user_signed_in?
    return unless current_user.competitions.active.count > 1 && @app_catch.nil?
    @app_catch = Catch.new
  end

  # Pass the name of the controller to the client. Derriving the controller name
  # from the URL is not reliable since the URL endpoint doesn't have to match
  # the name of the controller or action.
  def set_client_data
    @client_data = { controller: controller_name, action: action_name }
  end
end
