require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "repo_names returns the names of the repos" do
    assert_equal ["one_name"], users(:one).repo_names
  end
end
