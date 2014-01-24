class SecurityAlert < ActiveRecord::Base
  validates :desc, presence: true
  validates :version_fix, format: { with:  /\A\d+[.\d+.]*\z/, message: "x.y.z format" }, allow_nil: true, allow_blank: true
  validates :status, presence: true
  validates :status, format: { with: /\A[0-3]\Z/ }
  belongs_to :ruby_gem
  belongs_to :ruby_application
  STATUS_CODES = {
    0 => "Pending",
    1 => "Confirmed",
    2 => "Ignored"
  }

  def status_text
    STATUS_CODES[self.status]
  end

  def short_desc
    "#{desc[0..25]} ..."
  end

  def similars
    result = []
    sas = SecurityAlert.where("desc = '#{desc}' and id != '#{id}'")
    sas.each do |sa|
      result << SecurityAlert.new(
        :desc => sa.desc,
        :version_fix => sa.version_fix,
        :status => sa.status,
        :comment => sa.comment
      )
    end
    result
  end
end
