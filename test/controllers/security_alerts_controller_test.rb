require 'test_helper'

class SecurityAlertsControllerTest < ActionController::TestCase
  setup do
    @security_alert = security_alerts(:one)
  end

  test "should show security_alert" do
    get :show, id: @security_alert
    assert_response :success
  end
end
