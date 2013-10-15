require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    session[:user_id] = User.find_by_name("one")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post :create, user: { name: @user.name, email: "new email", password: "secret", password_confirmation: "secret"} 
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path
  end

  test "should update user" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_redirected_to user_path(@user)
  end
end
