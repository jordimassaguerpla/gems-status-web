class RubyGem < ActiveRecord::Base
  validates :name, presence: true
  validates :version, presence: true
  validates :version, format: { with:  /\A\d+[.\d+.]*\z/, message: "x.y.z format" }
  has_many :ruby_application_ruby_gem_relationships
  has_many :ruby_applications, through: :ruby_application_ruby_gem_relationships
  has_many :security_alerts
end
