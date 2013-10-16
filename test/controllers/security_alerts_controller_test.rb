require 'test_helper'

class SecurityAlertsControllerTest < ActionController::TestCase
  setup do
    @security_alert = security_alerts(:one)
    session[:user_id] = users(:one).id
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
    patch :update, id: @security_alert, security_alert: { comment: @security_alert.comment, status: @security_alert.status, desc: @security_alert.desc, version_fix: @security_alert.version_fix }
    assert_redirected_to security_alert_path(assigns(:security_alert))
  end

  test "role security team should see" do
    session[:user_id] = users(:three).id
    get :show, id: @security_alert
    assert_response :success
  end

  test "role security team should not edit" do
    session[:user_id] = users(:three).id
    get :edit, id: @security_alert
    assert_redirected_to root_url
  end

  test "role security team should not update" do
    session[:user_id] = users(:three).id
    expected = SecurityAlert.count
    patch :update, id: @security_alert, security_alert: { comment: @security_alert.comment, status: @security_alert.status, desc: @security_alert.desc, version_fix: @security_alert.version_fix }
    assert_equal expected, SecurityAlert.count
    assert_redirected_to root_url 
  end
  test "guest should not see" do
    session[:user_id] = nil
    get :show, id: @security_alert
    assert_redirected_to new_session_path
  end

  test "guest should not edit" do
    session[:user_id] = nil
    get :edit, id: @security_alert
    assert_redirected_to new_session_path
  end

  test "guest should not update" do
    session[:user_id] = nil
    expected = SecurityAlert.count
    patch :update, id: @security_alert, security_alert: { comment: @security_alert.comment, status: @security_alert.status, desc: @security_alert.desc, version_fix: @security_alert.version_fix }
    assert_equal expected, SecurityAlert.count
    assert_redirected_to new_session_path 
  end
  test "member should see its own sec. alert" do
    session[:user_id] = users(:two)
    get :show, id: security_alerts(:two)
    assert_response :success
  end
  test "member should not see others sec. alert" do
    session[:user_id] = users(:two)
    get :show, id: security_alerts(:one)
    assert_redirected_to root_url
  end
  test "member should not edit others" do
    session[:user_id] = users(:two)
    get :edit, id: security_alerts(:one)
    assert_redirected_to root_url
  end

  test "member should not update others" do
    session[:user_id] = users(:two)
    expected = SecurityAlert.count
    sa = security_alerts(:one)
    patch :update, id: sa.id, security_alert: { comment: sa.comment, status: sa.status, desc: sa.desc, version_fix: sa.version_fix }
    assert_equal expected, SecurityAlert.count
    assert_redirected_to root_url 
  end
end
