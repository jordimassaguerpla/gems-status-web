class SecurityAlertsController < ApplicationController
  before_action :set_security_alert, only: [:show, :edit, :update]

  # GET /security_alerts/1
  # GET /security_alerts/1.json
  def show
    @path = "#{@security_alert.ruby_application.name}/#{@security_alert.ruby_gem.name}/#{@security_alert.short_desc}"
  end

  # GET /security_alerts/1/edit
  def edit
    @path = "#{@security_alert.ruby_application.name}/#{@security_alert.short_desc}"
    @security_alert = SecurityAlert.find(params[:id])
  end

  # PUT /security_alerts/1
  # PUT /security_alerts/1.json
  def update
    respond_to do |format|
      if @security_alert.update(security_alert_params)
        format.html { redirect_to @security_alert, notice: 'Security alert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @security_alert.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /security_alerts/1/similars
  # GET /security_alerts/1/similars.json
  def similars
    sa = SecurityAlert.find(params[:security_alert_id])
    if sa
      @similars = sa.similars
    else
      @similars = []
    end
    respond_to do |format|
      format.html { render action: 'similars' }
      if @similars
        format.json { render json: @similars }
      else
        format.json { render json: "no security alert with #{params[:id]}" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_alert
      @security_alert = SecurityAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_alert_params
      params.require(:security_alert).permit(:ruby_gem_id, :ruby_application_id, :desc, :version_fix, :status, :comment)
    end
end
