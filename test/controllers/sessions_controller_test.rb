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
    assert_redirected_to users_path
  end

  test "should create session and redirect to users if admin" do
    user = users(:one)
    post :create, email: user.email, password: "secret" 
    assert_equal session[:user_id], user.id
    assert_redirected_to users_path
  end

  test "should create session and redirect to home if not admin" do
    user = users(:two)
    post :create, email: user.email, password: "secret" 
    assert_equal session[:user_id], user.id
    assert_redirected_to home_path
  end

  test "should create session and redirect to reports if security team role" do
    user = users(:three)
    post :create, email: user.email, password: "secret" 
    assert_equal session[:user_id], user.id
    assert_redirected_to reports_path
  end

  test "should not create session if invalid credentials" do
    post :create, email: "invalid", password: "secret"
    assert session[:user_id].nil?
  end

  test "should destroy remove user_id from session" do
    session[:user_id] = users(:one).id
    delete :destroy, id: "null"
    assert session[:user_id].nil?
  end
end
