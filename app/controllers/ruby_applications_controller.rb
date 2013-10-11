class RubyApplicationsController < ApplicationController
  before_action :set_ruby_application, only: [:show, :edit, :update]
  skip_before_filter :authorize

  # GET /ruby_applications/1
  # GET /ruby_applications/1.json
  def show
  end

  # GET /ruby_applications/1/edit
  def edit
    @ruby_application = RubyApplication.find(params[:id])
    @user = @ruby_application.user
  end

  # PUT /ruby_application/1
  # PUT /ruby_application/1.json
  def update
    respond_to do |format|
      if @ruby_application.update(ruby_application_params)
        format.html { redirect_to @ruby_application.user, notice: 'Ruby application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ruby_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ruby_application/1
  # DELETE /ruby_application/1.json
  def destroy
    @ruby_application = RubyApplication.find(params[:id])
    @ruby_application.destroy
    respond_to do |format|
      format.html { redirect_to @ruby_application.user }
      format.json { head :no_content }
    end
  end

  # GET /ruby_application/new
  def new
    @ruby_application = RubyApplication.new
  end

  # POST /ruby_application
  # POST /ruby_application.json
  def create
    if !current_user
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: @ruby_application.errors, status: :unprocessable_entity }
      end
    end
    @ruby_application = RubyApplication.new(ruby_application_params)
    @ruby_application.user = current_user

    respond_to do |format|
      if @ruby_application.save
        format.html { redirect_to @ruby_application.user, notice: 'Ruby application was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ruby_application }
      else
        format.html { render action: 'new' }
        format.json { render json: @ruby_application.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ruby_application
      @ruby_application = RubyApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ruby_application_params
      params.require(:ruby_application).permit(:name, :filename, :gems_url)
    end
end
