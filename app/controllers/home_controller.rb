class HomeController < ApplicationController
  def index
    @security_alerts = []
    current_user.ruby_applications.each do |ra|
      sa = ra.filtered_security_alerts
      @security_alerts << sa
    end
    @security_alerts.flatten!
  end
  def sa_similars
    if !params["desc"]
      @similars = "specify desc"
      return
    end
    sa = SecurityAlert.new(
      :desc => params["desc"],
      :status => 0
    )
    @similars = sa.similars
    respond_to do |format|
      format.html { render 'sa_similars' }
      format.json { render json: @similars }
    end
  end
end
