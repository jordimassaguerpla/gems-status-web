require 'test_helper'
class User
  def authenticate(password)
    true
  end
end

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get new and redirect to home" do
    session[:user_id] = users(:two).id
    get :new
    assert_redirected_to home_path
  end

  test "should get new and redirect to reports if security team role" do
    session[:user_id] = users(:three).id
    get :new
    assert_redirected_to reports_path
  end

  test "should get new and redirect to users if admin" do
    session[:user_id] = users(:one).id
    get :new
    assert_redirected_to home_path
  end

end
