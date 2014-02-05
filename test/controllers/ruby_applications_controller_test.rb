require 'test_helper'

class RubyApplicationsControllerTest < ActionController::TestCase
  setup do
    @request.env['HTTPS'] = 'on'
    CONFIG["MAX_RUBY_APP_BY_USER"] = -1
    @ruby_application = ruby_applications(:two)
    session[:user_id] = users(:two)
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
    assert_redirected_to user_path(users(:two))
  end

  test "should not create more ruby applications than max" do
    CONFIG["MAX_RUBY_APP_BY_USER"] = RubyApplication.find_all_by_user_id(users(:two)).count
    errors_b4 = flash[:error]?flash[:error].length():0
    b4 = RubyApplication.count
    post :create, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    assert_equal b4, RubyApplication.count
    assert_redirected_to home_path
    assert flash[:error]
    assert flash[:error].length > errors_b4
  end

  test "should create less ruby applications than max" do
    CONFIG["MAX_RUBY_APP_BY_USER"] = RubyApplication.find_all_by_user_id(users(:two)).count + 1
    assert_difference("RubyApplication.count") do
      post :create, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    end
    assert_redirected_to user_path(users(:two))
  end

  test "should get edit" do
    get :edit, id: @ruby_application
    assert_response :success
  end

  test "should destroy ruby application" do
    assert_difference('RubyApplication.count', -1) do
      delete :destroy, id: @ruby_application
    end
    assert_redirected_to home_path
  end

  test "should update ruby application" do
    patch :update, id: @ruby_application, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    assert_redirected_to user_path(@ruby_application.user)
  end

  test "guest should do nothing" do
    session[:user_id] = nil
    expected = RubyApplication.count
    get :show, id: @ruby_application
    assert_redirected_to new_session_path
    patch :update, id: @ruby_application, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    assert_redirected_to new_session_path
    delete :destroy, id: @ruby_application
    assert_equal expected, RubyApplication.count
    assert_redirected_to new_session_path
    get :edit, id: @ruby_application
    assert_redirected_to new_session_path
    post :create, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    assert_equal expected, RubyApplication.count
    assert_redirected_to new_session_path
    get :new
    assert_redirected_to new_session_path
  end
  test "other should do nothing with others" do
    session[:user_id] = users(:three)
    expected = RubyApplication.count
    get :show, id: @ruby_application
    assert_redirected_to root_url
    patch :update, id: @ruby_application, ruby_application: { name: @ruby_application.name, filename: @ruby_application.filename, gems_url: @ruby_application.gems_url }
    assert_redirected_to root_url
    delete :destroy, id: @ruby_application
    assert_equal expected, RubyApplication.count
    assert_redirected_to root_url
    get :edit, id: @ruby_application
    assert_redirected_to root_url
  end

  test "can't get result without api token" do
    session[:user_id] = nil
    get :result, ruby_application_id: @ruby_application.id
    assert_redirected_to new_session_path
  end

  test "can get result 'false' with api token" do
    session[:user_id] = nil
    get :result, ruby_application_id: @ruby_application.id, api_access_token: users(:two).api_access_token 
    assert_response :success
    assert !@ruby_application.result
  end

  test "can get result 'true' with api token" do
    session[:user_id] = nil
    get :result, ruby_application_id: ruby_applications(:three).id, api_access_token: users(:two).api_access_token 
    assert_response :success
    assert ruby_applications(:three).result
  end

  test "can't get result with api token if not owner" do
    session[:user_id] = nil
    get :result, ruby_application_id: @ruby_application.id, api_access_token: users(:three).api_access_token 
    assert_redirected_to root_url
  end

  test "can't get result if non beta user" do
    session[:user_id] = users(:five)
    get :result, ruby_application_id: @ruby_application.id, api_access_token: users(:three).api_access_token 
    assert_redirected_to root_url
  end


end
