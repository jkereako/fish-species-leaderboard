module DeviseHelper
  def devise_error_messages!
    resource.errors.full_messages.map do |message|
      flash[:error] = message
    end
    flash.discard
  end
end
