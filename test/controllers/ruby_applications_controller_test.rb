require 'test_helper'

class RubyApplicationsControllerTest < ActionController::TestCase
  setup do
    @ruby_application = ruby_applications(:one)
    session[:user_id] = User.find_by_name("one")
  end

  test "should show ruby_application" do
    get :show, id: @ruby_application
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ruby application" do
    assert_difference("RubyApplication.count") do
      post :create, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
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

  test "should update ruby application" do
    patch :update, id: @ruby_application, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    assert_redirected_to user_path(@ruby_application.user)
  end
end
