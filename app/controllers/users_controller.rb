class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @path = User.find(params[:id]).name
  end

  # GET /users/1/import_repos
  def import_repos
    @user = User.find(params[:user_id])
    @user.delay.import_repos
    redirect_to @user, notice: "Import repos action triggered"
  end

  # GET /users/1/generate_access_token
  def generate_access_token
    @user = User.find(params[:user_id])
    @user.generate_access_token!
    @user.save
    redirect_to @user, notice: "Access token generated"
  end

  # GET /users/1/switch_on_email
  def switch_on_email
    @user = User.find(params[:user_id])
    @user.receive_emails = 1
    @user.save
    redirect_to @user
  end

  # GET /users/1/switch_off_email
  def switch_off_email
    @user = User.find(params[:user_id])
    @user.receive_emails = 0
    @user.save
    redirect_to @user
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
    require "debugger";debugger
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user/1
  # PUT /user/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :role, :beta_user)
    end
end
