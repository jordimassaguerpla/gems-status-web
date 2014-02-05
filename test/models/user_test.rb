require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "repo_names returns the names of the repos" do
    assert_equal ["one_name"], users(:one).repo_names
  end
  test "generate access token" do
    u = users(:one)
    b4 = u.api_access_token
    u.generate_access_token!
    after = u.api_access_token
    assert_not_equal(b4, after)
  end
  test "reviewed_sa" do
    u = users(:one)
    assert_equal 1, u.reviewed_sa
    u = users(:two)
    assert_equal 0, u.reviewed_sa
  end
end
