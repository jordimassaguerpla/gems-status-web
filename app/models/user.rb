class User < ActiveRecord::Base
  before_create :generate_access_token
  has_many :ruby_applications
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :times_logged_in, numericality: { only_integer: true }

  has_secure_password

  private
  def generate_access_token
    begin
      self.api_access_token = SecureRandom.hex
    end while self.class.exists?(api_access_token: api_access_token)
  end

end
