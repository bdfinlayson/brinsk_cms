class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
