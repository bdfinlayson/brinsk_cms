class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_devise_params, if: :devise_controller?
  before_action :authenticate_user!

  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end
end
