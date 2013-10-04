require 'test_helper'

class RubyApplicationsControllerTest < ActionController::TestCase
  setup do
    @ruby_application = ruby_applications(:one)
  end

  test "should show ruby_application" do
    get :show, id: @ruby_application
    assert_response :success
  end
end
