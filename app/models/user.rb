class User < ActiveRecord::Base
  has_many :ruby_applications
  validates :name, presence: true
  validates :email, presence: true
end
