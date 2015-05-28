class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_client_data
  before_action :set_json_response, only: [:create, :update]

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

  # Pass the name of the controller to the client.
  def set_client_data
    @client_data = params.slice :controller
  end
end
