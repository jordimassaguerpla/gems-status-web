class User < ActiveRecord::Base
  before_create :generate_access_token
  has_many :ruby_applications
  has_many :repos
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def repo_names
    result = []
    repos.each do |repo|
      result << repo.name
    end
  end

  def import_repos
    # TODO: error handling
    if auth_token
      Rails.logger.debug "initializing octokit"
      client = Octokit::Client.new :access_token => auth_token
      user = client.user
      Rails.logger.debug "login"
      user.login 
      Rails.logger.debug "get repos"
      repos = user.rels[:repos].get.data
      repos.each do |repo|
        if !Repo.find_by_name(repo.name)
          begin
            filename = "https://raw.github.com/#{user.name}/#{repo.name}/master/Gemfile.lock"
            Rails.logger.debug "trying to download #{filename}"
            open(filename)
            Rails.logger.debug "saving repo to database"
            r = Repo.new
            r.name = repo.name
            r.save
            repos << r
          rescue
          end
        end
      end
      save
    end
  end
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
