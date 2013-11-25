class User < ActiveRecord::Base
  before_create :generate_access_token
  has_many :ruby_applications
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  private
  def generate_access_token
    begin
      self.api_access_token = SecureRandom.hex
    end while self.class.exists?(api_access_token: api_access_token)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
    end
  end

end
