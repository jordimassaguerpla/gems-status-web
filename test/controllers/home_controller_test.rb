require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    @request.env['HTTPS'] = 'on'
    @user = users(:two)
    session[:user_id] = User.find_by_name("two")
  end

  test "should show sa_similars with a user" do
    session[:user_id] = User.find_by_name("two")
    get :sa_similars
    assert_response :success
  end

  test "should not show sa_similars with no user" do
    session[:user_id] = nil
    get :sa_similars
    assert_redirected_to new_session_path
  end

  test "index" do
    get 'index'
    assert_response :success
  end

  test "ping" do
    session[:user_id] = nil
    get 'ping'
    assert_response :success
  end
end
