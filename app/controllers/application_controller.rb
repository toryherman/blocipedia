class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def user_not_authorized(exception)
    flash[:alert] = "You do not have access to that."
    redirect_to(request.referrer || root_path)
  end
end
