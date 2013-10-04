namespace :db do
  namespace :populate do
    desc "Populate database with example data"
    task :example_data => :environment do
      # delete all
      User.delete_all
      RubyApplication.delete_all
      RubyGem.delete_all
      SecurityAlert.delete_all

      # users
      u = User.new
      u.name = "Forrest Gump"
      u.save
      u = User.new
      u.name = "Dan Taylor"
      u.save

      # ruby applications
      ra = RubyApplication.new
      ra.name = "ui-server"
      ra.filename = "/tmp/ui-server/Gemfile.lock"
      ra.gems_url = "https://rubygems.org"
      ra.user = User.find_by_name "Forrest Gump"
      ra.save
      ra = RubyApplication.new
      ra.name = "runner"
      ra.filename = "/tmp/runner/Gemfile.lock"
      ra.gems_url = "https://rubygems.org"
      ra.user = User.find_by_name "Dan Taylor"
      ra.save

      # ruby gems
      rg = RubyGem.new
      rg.name = "rails"
      rg.version = "4.0.0"
      rg.license = "MIT"
      rg.ruby_applications = RubyApplication.all
      rg.save
      rg = RubyGem.new
      rg.name = "curb"
      rg.version = "0.8.5"
      rg.license = "Ruby"
      rg.ruby_applications = [RubyApplication.find_by_name("runner")]
      rg.save

      # security alerts
      sa = SecurityAlert.new
      sa.desc = "CVEXXX: security alert , bla bla bla"
      sa.version_fix = "1.1.1"
      sa.ruby_gem = RubyGem.find_by_name("rails")
      sa.ruby_application = RubyApplication.find_by_name("ui-server")
      sa.save
    end
  end
end

