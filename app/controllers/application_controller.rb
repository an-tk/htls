class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  rescue_from User::NotAuthorized, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :remember_me) }
  end

  private

  def user_not_authorized
    flash[:error] = "You don't have access to this page."
    redirect_to root_path
  end
end
