class HomeController < ApplicationController
  def index
    @security_alerts = []
    current_user.ruby_applications.each do |ra|
      sa = ra.filtered_security_alerts
      @security_alerts << sa
    end
    @security_alerts.flatten!
  end

  def ping
  end

end
