class RubyApplication < ActiveRecord::Base
  validates :name, presence: true
  validates :filename, presence: true
  validates :gems_url, presence: true
  belongs_to :user
  has_many :ruby_application_ruby_gem_relationships
  has_many :ruby_gems, through: :ruby_application_ruby_gem_relationships
  has_many :security_alerts
end
