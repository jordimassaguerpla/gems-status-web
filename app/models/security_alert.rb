class SecurityAlert < ActiveRecord::Base
  belongs_to :ruby_gem
  belongs_to :ruby_application
  STATUS_CODES = {
    0 => "Pending",
    1 => "Confirmed",
    2 => "Ignored",
    3 => "Refused"
  }

  def status_text
    STATUS_CODES[self.status]
  end

  def short_desc
    "#{desc[0..25]} ..."
  end
end
