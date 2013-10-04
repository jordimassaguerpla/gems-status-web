class SecurityAlertsController < ApplicationController
  before_action :set_security_alert, only: [:show]

  # GET /security_alerts/1
  # GET /security_alerts/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_alert
      @security_alert = SecurityAlert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_alert_params
      params.require(:security_alert).permit(:gem_id, :ruby_application_id, :desc, :version_fix)
    end
end
