class RubyApplication < ActiveRecord::Base
  belongs_to :user
  has_many :ruby_application_ruby_gem_relationships
  has_many :ruby_gems, through: :ruby_application_ruby_gem_relationships
  has_many :security_alerts
end
