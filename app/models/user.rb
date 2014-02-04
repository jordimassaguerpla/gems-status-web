require "open-uri"

class User < ActiveRecord::Base
  before_create :generate_access_token
  has_many :ruby_applications
  has_many :repos
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :times_logged_in, numericality: { only_integer: true }
  
  has_secure_password(validations: false)

  def repo_names
    repos.collect(&:name)
  end

  def import_repos
    return unless auth_token
    Rails.logger.debug "initializing octokit"
    begin
      client = Octokit::Client.new :access_token => auth_token
      user = client.user
      if user.nil?
        Rails.logger.error "there was some kind of problem logging to github"
        return
      end
      Rails.logger.debug "login"
      user.login
      Rails.logger.debug "get repos"
      repos = user.rels[:repos]
      if repos.nil?
        Rails.logger.error "there was some kind of problem getting repos from github"
        return
      end
      repos = repos.get
      if repos.nil?
        Rails.logger.error "there was some kind of problem getting repos from github"
        return
      end
      repos = repos.data
      if repos.nil?
        Rails.logger.error "there was some kind of problem getting repos from github"
        return
      end
    rescue Exception => e
      Rails.logger.error "there was some kind of problem interacting with github #{e.message}"
      return
    end
    return if !repos
    repos.each do |repo|
      if !Repo.find_by_name(repo.name)
        begin
          filename = "https://raw.github.com/#{name}/#{repo.name}/master/Gemfile.lock"
          Rails.logger.debug "trying to download #{filename}"
          open(filename)
        rescue
          Rails.logger.debug "#{filename} does not exist. Ignoring repo ..."
          next
        end
        Rails.logger.debug "saving repo to database"
        r = Repo.new
        r.name = repo.name
        r.user = self
        if !r.save
          Rails.logger.debug "Some error occured saving repo #{r.name}"
        end
      end
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
