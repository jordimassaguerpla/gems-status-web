class SecurityAlert < ActiveRecord::Base
  belongs_to :ruby_gem
  belongs_to :ruby_application

  def short_desc
    "#{desc[0..25]} ..."
  end
end
