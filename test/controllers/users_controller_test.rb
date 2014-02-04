require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:two)
    session[:user_id] = User.find_by_name("two")
  end

  test "admin should get index" do
    session[:user_id] = users(:one).id
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "member should not get index" do
    get :index
    assert_redirected_to root_url
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "admin should get new" do
    session[:user_id] = users(:one).id
    get :new
    assert_response :success
  end

  test "member should not get new" do
    get :new
    assert_redirected_to root_url
  end

  test "user should not create user" do
    expected = User.count
    post :create, user: { name: @user.name, email: "new email", password: "secret", password_confirmation: "secret"} 
    assert_equal expected, User.count
    assert_redirected_to root_url
  end

  test "user should not create user with github" do
    CONFIG['GITHUB_INTEGRATION'] = true
    expected = User.count
    post :create, user: { name: @user.name, email: "new email"} 
    assert_equal expected, User.count
    assert_redirected_to root_url
  end

  test "admin should create user" do
    session[:user_id] = users(:one)
    assert_difference("User.count") do
      post :create, user: { name: @user.name, email: "new email", password: "secret", password_confirmation: "secret"} 
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "admin should create user with github" do
    session[:user_id] = users(:one)
    assert_difference("User.count") do
      post :create, user: { name: @user.name, email: "new email"} 
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should'nt get edit if not admin" do
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test "should get edit if admin" do
    session[:user_id] = users(:one)
    get :edit, id: @user
    assert_response :success
  end

  test "shouldn't destroy user if not admin" do
    assert_difference('User.count', 0) do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should destroy user if admin" do
    session[:user_id] = users(:one)
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path
  end

  test "shouldn't update user if not admin" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to root_url
  end

  test "should update user if admin" do
    session[:user_id] = users(:one)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to user_path(@user)
  end

  test "guest should not do anything" do
    session[:user_id] = nil
    expected = User.count
    get :index
    assert_redirected_to new_session_path
    get :show, id: @user
    assert_redirected_to new_session_path
    delete :destroy, id: @user
    assert_equal expected, User.count
    assert_redirected_to new_session_path
    get :edit, id: @user
    assert_redirected_to new_session_path
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_equal expected, User.count
    assert_redirected_to new_session_path
  end
  test "member should not do anything on others" do
    user = users(:one)
    expected = User.count
    get :index
    assert_redirected_to root_url
    get :show, id: user
    assert_redirected_to root_url
    delete :destroy, id: user
    assert_equal expected, User.count
    assert_redirected_to root_url
    get :edit, id: user
    assert_redirected_to root_url
    patch :update, id: user, user: { name: user.name, email: user.email }
    assert_equal expected, User.count
    assert_redirected_to root_url
  end
  test "a non-beta user should not do anything" do
    session[:user_id] = users(:four)
    expected = User.count
    get :index
    assert_redirected_to root_url
    get :show, id: @user
    assert_redirected_to root_url
    delete :destroy, id: @user
    assert_equal expected, User.count
    assert_redirected_to root_url
    get :edit, id: @user
    assert_redirected_to root_url
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_equal expected, User.count
    assert_redirected_to root_url
  end
end
