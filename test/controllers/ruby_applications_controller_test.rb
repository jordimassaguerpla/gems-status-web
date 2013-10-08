require 'test_helper'

class RubyApplicationsControllerTest < ActionController::TestCase
  setup do
    @ruby_application = ruby_applications(:one)
  end

  test "should show ruby_application" do
    get :show, id: @ruby_application
    assert_response :success
  end

  test "should get new" do
    session[:user_id] = User.find_by_name("one")
    get :new
    assert_response :success
  end

  test "should create ruby application" do
    session[:user_id] = User.find_by_name("one")
    assert_difference("RubyApplication.count") do
      post :create, ruby_application: { name: @ruby_application.name }
    end
    assert_redirected_to user_path(User.find_by_name("one"))
  end

  test "should get edit" do
    get :edit, id: @ruby_application
    assert_response :success
  end

  test "should destroy ruby application" do
    assert_difference('RubyApplication.count', -1) do
      delete :destroy, id: @ruby_application
    end
    assert_redirected_to user_path @ruby_application.user
  end
end
