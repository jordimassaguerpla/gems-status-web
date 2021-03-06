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
      u.email = "fg@nodomain.no"
      u.password = "secret"
      u.password_confirmation = "secret"
      u.save
      u = User.new
      u.name = "Dan Taylor"
      u.email = "dt@nodomain.no"
      u.password = "secret"
      u.password_confirmation = "secret"
      u.save

      # ruby applications
      ra = RubyApplication.new
      ra.name = "ui-server"
      ra.filename = File.expand_path('../../../test/files/1/Gemfile.lock', __FILE__)
      ra.gems_url = "https://rubygems.org/gems"
      ra.user = User.find_by_name "Forrest Gump"
      ra.save
      ra = RubyApplication.new
      ra.name = "runner"
      ra.filename = File.expand_path('../../../test/files/2/Gemfile.lock', __FILE__)
      ra.gems_url = "https://rubygems.org/gems"
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
      sa.version_fix = "5.0.0"
      sa.ruby_gem = RubyGem.find_by_name("rails")
      sa.ruby_application = RubyApplication.find_by_name("ui-server")
      sa.status = 0
      sa.save
      sa = SecurityAlert.new
      sa.desc = "CVEYYY: security alert , bla bla bla"
      sa.version_fix = ""
      sa.ruby_gem = RubyGem.find_by_name("rails")
      sa.ruby_application = RubyApplication.find_by_name("ui-server")
      sa.status = 0
      sa.save
      sa = SecurityAlert.new
      sa.desc = "CVEZZZ: security alert , bla bla bla"
      sa.version_fix = ""
      sa.ruby_gem = RubyGem.find_by_name("rails")
      sa.ruby_application = RubyApplication.find_by_name("ui-server")
      sa.status = 0
      sa.comment = "This is a false positive because it refers to documentation"
      sa.save
      sa = SecurityAlert.new
      sa.desc = "CVEZZZ: security alert , bla bla bla"
      sa.version_fix = ""
      sa.ruby_gem = RubyGem.find_by_name("rails")
      sa.ruby_application = RubyApplication.find_by_name("runner")
      sa.status = 0
      sa.save
      sa = SecurityAlert.new
      sa.desc = "CVEAAA: security alert , bla bla bla"
      sa.version_fix = ""
      sa.ruby_gem = RubyGem.find_by_name("curb")
      sa.ruby_application = RubyApplication.find_by_name("runner")
      sa.status = 0
      sa.save
      lr = LastRun.new
      lr.save
    end
  end
end

