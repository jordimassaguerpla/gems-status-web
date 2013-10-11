class User < ActiveRecord::Base
  has_many :ruby_applications
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_secure_password

end
