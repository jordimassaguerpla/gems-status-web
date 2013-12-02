class SessionsController < ApplicationController
  skip_before_filter :authenticate
  skip_before_filter :authorize
  def new
    if current_user
      redirect_to reports_path if is_from_security_team?
      redirect_to home_path
    end
  end
  
  def create
    user = user_by_params
    if user
      session[:user_id] = user.id
      redirect_to reports_path if is_from_security_team?
      redirect_to home_path
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
