class RubyApplication < ActiveRecord::Base
  validates :name, presence: true
  validates :filename, presence: true
  validates :gems_url, presence: true
  belongs_to :user
  has_many :ruby_application_ruby_gem_relationships
  has_many :ruby_gems, through: :ruby_application_ruby_gem_relationships
  has_many :security_alerts

  def result
    num_alerts = 0
    ruby_gems.each do |rg|
          security_alerts.where("ruby_gem_id == '?'", rg.id).each do |sa|
            next if sa.version_fix && sa.version_fix != "" && Gem::Version.new(sa.version_fix) < Gem::Version.new(rg.version)
            next if SecurityAlert::STATUS_CODES[sa.status] == "Ignored"
            next if SecurityAlert::STATUS_CODES[sa.status] == "Refused"
            num_alerts = num_alerts + 1
          end
    end
    num_alerts == 0
  end
end
