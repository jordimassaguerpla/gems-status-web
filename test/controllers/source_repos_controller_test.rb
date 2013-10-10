require 'test_helper'

class SourceReposControllerTest < ActionController::TestCase
  setup do
    @source_repo = source_repos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:source_repos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create source_repo" do
    assert_difference('SourceRepo.count') do
      post :create, source_repo: { name: @source_repo.name, url: @source_repo.url }
    end

    assert_redirected_to source_repo_path(assigns(:source_repo))
  end

  test "should show source_repo" do
    get :show, id: @source_repo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @source_repo
    assert_response :success
  end

  test "should update source_repo" do
    patch :update, id: @source_repo, source_repo: { name: @source_repo.name, url: @source_repo.url }
    assert_redirected_to source_repo_path(assigns(:source_repo))
  end

  test "should destroy source_repo" do
    assert_difference('SourceRepo.count', -1) do
      delete :destroy, id: @source_repo
    end

    assert_redirected_to source_repos_path
  end
end
