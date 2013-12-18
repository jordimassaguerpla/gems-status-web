require 'test_helper'

class RubyApplicationTest < ActiveSupport::TestCase
  test "get gems with security alerts" do
    @ruby_application = ruby_applications(:one)
    sa = @ruby_application.gems_with_security_alerts
    assert_equal 0, sa.length
    @ruby_application = ruby_applications(:two)
    sa = @ruby_application.gems_with_security_alerts
    assert_equal 1, sa.length
    assert_equal security_alerts(:two).ruby_gem.name, sa.first
  end
end
