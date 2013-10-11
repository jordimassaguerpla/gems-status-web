class SessionsController < ApplicationController
  skip_before_filter :authenticate
  skip_before_filter :authorize
  def new
    if current_user
      if is_admin?
        redirect_to users_path
      else
        redirect_to user_path(current_user)
      end
    end
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if is_admin?
        redirect_to users_path
      else
        redirect_to user_path(current_user)
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
