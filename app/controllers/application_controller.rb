class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_client_data
  before_action :user_competing_in_multiple_competitions?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Handle the exception raised by Pundit when a user is unauthorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to url_for new_user_session_path
  end

  private

  def user_competing_in_multiple_competitions?
    return unless user_signed_in?
    return unless current_user.competitions.active.count > 1 && @catch.nil?
    @catch = Catch.new
  end

  # Pass the name of the controller to the client. Derriving the controller name
  # from the URL is not reliable since the URL endpoint doesn't have to match
  # the name of the controller or action.
  def set_client_data
    @client_data = { controller: controller_name, action: action_name }
  end
end
