class ApplicationController < ActionController::Base
  before_filter :authenticate
  before_filter :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :check_authentication
  helper_method :is_admin?
  helper_method :is_from_security_team?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to new_session_path unless current_user
  end

  def is_admin?
    !current_user.nil? && current_user.admin == 1
  end

  def authorize
    return false if is_admin?
    return false if is_from_security_team? && params[:controller] == "reports" && params[:action] == "index"
    return false if is_from_security_team? && params[:controller] == "security_alerts" && params[:action] == "show"
    return false if current_user && params[:controller] == "ruby_applications" && ["new", "create"].include?(params[:action])
    return false if current_user && params[:controller] == "ruby_applications" && params[:id] && current_user.ruby_applications.include?(RubyApplication.find(params[:id]))
    return false if current_user && params[:controller] == "security_alerts" && params[:id] && current_user.ruby_applications.include?(SecurityAlert.find(params[:id]).ruby_application)
    return false if current_user && params[:controller] == "users" && params[:id] && params[:id] == current_user.id.to_s
    flash[:error] = "Unauthorized access"
    redirect_to root_url
  end

  def is_from_security_team?
    !current_user.nil? && current_user.role == 1
  end

end
