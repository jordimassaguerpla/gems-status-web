require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "redirect if no current_user" do
    session[:user_id] = nil
    get :index
    assert_redirected_to new_session_path
  end
  test "redirect if only member" do
    session[:user_id] = users(:two).id
    get :index
    assert_redirected_to root_url
  end
  test "get index if admin" do
    session[:user_id] = users(:one).id
    get :index
    assert_response :success
  end
  test "get index if role security_team" do
    session[:user_id] = users(:three).id
    get :index
    assert_response :success
  end
end
