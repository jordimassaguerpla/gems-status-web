class RubyGem < ActiveRecord::Base
  has_many :ruby_application_ruby_gem_relationships
  has_many :ruby_applications, through: :ruby_application_ruby_gem_relationships
  has_many :security_alerts
end
