# I know this is very very ugly and hacky but seems that heroku has a limitation in the git binary they have installed
#  git clone http://.... does not work
#  git clone https://... does
# thus, I am rewriting the gem_uri function
# I hope one day I can remove this hack
# FIXME in the future
module GemsStatus
  class NotASecurityAlertChecker

    private

    def gem_uri(gem_version_information)
      result = nil
      if gem_version_information["project_uri"] &&
         gem_version_information["project_uri"].include?("github")
        result = gem_version_information["project_uri"]
      elsif gem_version_information["homepage_uri"] &&
         gem_version_information["homepage_uri"].include?("github")
        result = gem_version_information["homepage_uri"]

      elsif gem_version_information["source_code_uri"] &&
         gem_version_information["source_code_uri"].include?("github")
        result = gem_version_information["source_code_uri"]

      else
        return nil
      end
      result.gsub("http:","https:").gsub("www.github","github")
    end
  end
end

class GemsStatusWrapper

  def run(ruby_application)
    begin
      local_path = "/tmp/gemfiles/#{ruby_application.name}"
      local_filename = local_path + "/" + "Gemfile.lock"
      FileUtils.mkdir_p local_path 
      gemfile = open(ruby_application.filename) {|f| f.read }
      File.open(local_filename, "w") {|f| f.write(gemfile)}
    rescue
      puts "ERROR: Problems getting #{ruby_application.name} and saving it to #{local_filename}"
      return
    end
    conf = {
      "classname" => "LockfileGems",
      "filename" => local_filename,
      "gems_url" => ruby_application.gems_url
    }
    runner = GemsStatus::Runner.new
    runner.source = GemsStatus::LockfileGems.new(conf)
    checker = not_a_security_alert_checker(ruby_application)
    runner.add_checker(checker) if checker
    runner.execute
    insert_into_database(runner, ruby_application)
    lr = LastRun.new
    if !lr.save
      puts "ERROR: There was a problem saving #{lr}"
    end
  end

  private

  def not_a_security_alert_checker(ruby_application)
      return nil if !ENV["GMAIL_USERNAME"]
      return nil if !ENV["GMAIL_PASSWORD"]
      return nil if !ENV["MAILING_LISTS"]
      source_repos = {}
      SourceRepo.all.to_a.each { |a| source_repos[a.name] = a.url }
      fixed = {}
      SecurityAlert.all.each do |sa|
        next if sa.sec_key.nil? || sa.sec_key.blank?
        if sa.status == 2 || sa.status == 3
          fixed[sa.sec_key] = "0.0.0"
        elsif sa.status == 1 && !sa.version_fix.nil? && !sa.version_fix.blank?
          fixed[sa.sec_key] = sa.version_fix
        end
      end
      conf = {
        "classname" => "NotASecurityAlertChecker",
        "fixed" => fixed,
        "source_repos" => source_repos,
        "email_username" => ENV["GMAIL_USERNAME"],
        "email_password" => ENV["GMAIL_PASSWORD"],
        "mailing_lists" => ENV["MAILING_LISTS"].split,
        "email_to" => [ruby_application.user.email]

      }
      GemsStatus::NotASecurityAlertChecker.new(conf)
  end

  def insert_into_database(runner, ruby_application)
    puts "DEBUG: ------- Inserting into database -----------------"
    insert_gems(runner, ruby_application)
    insert_alerts(runner, ruby_application)
  end

  def insert_gems(runner, ruby_application)
    puts "DEBUG: Inserting gems"
    ruby_application.ruby_gems.delete_all
    runner.gem_list.each do |name, gem|
      puts "DEBUG: #{name}"
      rg = RubyGem.find_by(:name => gem.name, :version => gem.version.to_s)
      if rg.nil?
        rg = RubyGem.new
        rg.name = gem.name
        rg.version = gem.version.to_s
        rg.license = gem.license
        rg.ruby_applications = [ruby_application]
        if !rg.save
          puts "ERROR: There was a problem inserting #{name} gem into the database"
        end
      else
        rg.ruby_applications << ruby_application unless rg.ruby_applications.include? ruby_application
        if !rg.save
          puts "ERROR: There was a problem inserting #{name} gem into the database"
        end
      end
    end
  end

  def insert_alerts(runner, ruby_application)
    puts "DEBUG: Inserting alerts"
    runner.checker_results.each do |_, alerts|
      alerts.each do |alert|
        alert.security_messages.each do |sec_key, message|
          desc= message.desc.gsub("'","-").gsub('"',"-")
          gem = alert.gem
          puts "DEBUG: Adding alert for #{gem.name}"
          rg = RubyGem.find_by(:name => gem.name, :version => gem.version.to_s)
          if rg.nil?
            puts "ERROR: I could not find #{gem.name} : #{gem.version.to_s}"
            exit -1
          end
          sa = SecurityAlert.find_by(:sec_key => sec_key)
          sa = SecurityAlert.new if sa.nil?
          sa.desc = desc
          sa.ruby_gem = rg
          sa.ruby_application = ruby_application
          sa.version_fix = ""
          sa.status = 0
          sa.comment = ""
          sa.sec_key = sec_key
          if !sa.save
            puts "ERROR: There was a problem inserting #{sa.sec_key} into the database"
          end
        end
      end
    end
  end

end
