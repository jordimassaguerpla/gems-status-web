class SecurityAlert < ActiveRecord::Base
  belongs_to :ruby_gem
  belongs_to :ruby_application

  def status_text
    status_codes = {
      0 => "Pending",
      1 => "Confirmed",
      2 => "Ignored",
      3 => "Refused"
    }
    status_codes[self.status]
  end

  def short_desc
    "#{desc[0..25]} ..."
  end
end
