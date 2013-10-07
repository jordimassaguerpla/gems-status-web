require 'test_helper'

class SecurityAlertsControllerTest < ActionController::TestCase
  setup do
    @security_alert = security_alerts(:one)
  end

  test "should show security_alert" do
    get :show, id: @security_alert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @security_alert
    assert_response :success
  end

  test "should update security alert" do
    patch :update, id: @security_alert, security_alert: { comment: @security_alert.comment, status: @security_alert.status }
    assert_redirected_to security_alert_path(assigns(:security_alert))
  end
end
