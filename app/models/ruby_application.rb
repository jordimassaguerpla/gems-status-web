require "gems_status_wrapper"

class RubyApplication < ActiveRecord::Base
  validates :name, presence: true
  validates :filename, presence: true
  validates :gems_url, presence: true
  belongs_to :user
  has_many :ruby_application_ruby_gem_relationships
  has_many :ruby_gems, through: :ruby_application_ruby_gem_relationships
  has_many :security_alerts

  def result
    filtered_security_alerts.length == 0
  end

  def gems_with_security_alerts
    gems = []
    filtered_security_alerts.each do |sa|
      gems << sa.ruby_gem.name
    end
    gems.uniq!
  end

  def filtered_security_alerts
    return @security_alerts if @security_alerts
    @sa = []
    return @sa unless ruby_gems
    ruby_gems.each do |rg|
      security_alerts.where("ruby_gem_id = '?'", rg.id).each do |sa|
        next unless sa.ruby_application
        next if sa.version_fix && sa.version_fix != "" && Gem::Version.new(sa.version_fix) <= Gem::Version.new(rg.version)
        next if SecurityAlert::STATUS_CODES[sa.status] == "Ignored"
        next if SecurityAlert::STATUS_CODES[sa.status] == "Refused"
        @sa << sa
      end
    end
    @sa
  end
  def run_report
    GemsStatusWrapper.new.run(self)
  end
end
