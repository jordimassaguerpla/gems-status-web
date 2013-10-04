class RubyApplicationRubyGemRelationship < ActiveRecord::Base
  belongs_to :ruby_application
  belongs_to :ruby_gem
end
