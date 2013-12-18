require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  setup do
    @user = users(:two)
    session[:user_id] = User.find_by_name("two")
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
