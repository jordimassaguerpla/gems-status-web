class RubyGemRubyApplication < ActiveRecord::Base
  belongs_to :ruby_gem
  belongs_to :ruby_application
end
