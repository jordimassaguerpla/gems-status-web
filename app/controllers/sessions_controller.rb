class SessionsController < ApplicationController
  skip_before_filter :authenticate
  skip_before_filter :authorize
  def new
    if current_user
      if is_admin?
        redirect_to users_path
      elsif is_from_security_team?
        redirect_to reports_path
      else
        redirect_to home_path
      end
    end
  end
  
  def create
    user = user_by_params
    if user
      session[:user_id] = user.id
      if is_admin?
        redirect_to users_path
      elsif is_from_security_team?
        redirect_to reports_path
      else
        redirect_to home_path
      end
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil if session[:user_id]
    redirect_to root_url
  end


end
