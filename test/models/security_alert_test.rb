require 'test_helper'

class SecurityAlertTest < ActiveSupport::TestCase
  test "similars" do
    sa1 = security_alerts(:one)
    sa1.desc ="A"
    sa1.save
    sa2 = security_alerts(:two)
    sa2.desc = "B"
    sa2.save
    result = sa1.similars
    assert(!result.include?(sa2))
    sa2.desc = "A"
    sa2.save
    result = sa1.similars
    assert(result.include?(sa2))
  end
end
