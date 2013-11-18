class GemsStatusWrapper

  def run(ruby_application)
    conf = {
      "classname" => "LockfileGems",
      "filename" => ruby_application.filename,
      "gems_url" => ruby_application.gems_url
    }
    runner = GemsStatus::Runner.new
    runner.source = GemsStatus::LockfileGems.new(conf)
    runner.add_checker(not_a_security_alert_checker(ruby_application))
    runner.execute
    insert_into_database(runner, ruby_application)
    lr = LastRun.new
    lr.save
  end

  private

  def not_a_security_alert_checker(ruby_application)
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
        "email_username" => CONFIG["GMAIL_USERNAME"],
        "email_password" => CONFIG["GMAIL_PASSWORD"],
        "mailing_lists" => CONFIG["mailing_lists"],
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
    runner.gem_list.each do |name, gem|
      puts "DEBUG: #{name}"
      if !RubyGem.exists?(:name => gem.name, :version => gem.version.to_s)
        rg = RubyGem.new
        rg.name = gem.name
        rg.version = gem.version.to_s
        rg.license = gem.license
        rg.ruby_applications = [ruby_application]
        rg.save
      else
        rg = RubyGem.find_by(:name => gem.name, :version => gem.version.to_s)
        rg.ruby_applications << ruby_application unless rg.ruby_applications.include? ruby_application
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
          next if SecurityAlert.exists?(:sec_key => sec_key, :ruby_gem_id => rg.id, :ruby_application_id => ruby_application.id)
          sa = SecurityAlert.new
          sa.desc = desc
          sa.ruby_gem = rg
          sa.ruby_application = ruby_application
          sa.version_fix = ""
          sa.status = 0
          sa.comment = ""
          sa.sec_key = sec_key
          sa.save
        end
      end
    end
  end

end