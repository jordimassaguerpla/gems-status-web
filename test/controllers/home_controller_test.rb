require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "ping" do
    get 'ping'
    assert_response :success
  end
end
