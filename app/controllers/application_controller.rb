class ApplicationController < ActionController::Base
  before_filter :authenticate
  before_filter :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :check_authentication
  helper_method :is_admin?

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
    unless is_admin?
      flash[:error] = "Unauthorized access"
      redirect_to root_url
    end
    false
  end

end
