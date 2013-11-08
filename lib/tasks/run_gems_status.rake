namespace :gems_status do
  desc "Run gems-status"
  task :run => :environment do
    RubyApplication.all.each do |ra|
      conf = {
        "classname" => "LockfileGems",
        "filename" => ra.filename,
        "gems_url" => ra.gems_url
      }
      runner = GemsStatus::Runner.new
      runner.source = GemsStatus::LockfileGems.new(conf)
      source_repos = {}
      SourceRepo.all.to_a.each { |a| source_repos[a.name] = a.url }
      conf = {
        "classname" => "NotASecurityAlertChecker",
        "fixed" => {},
        "source_repos" => source_repos,
        "email_username" => CONFIG["GMAIL_USERNAME"],
        "email_password" => CONFIG["GMAIL_PASSWORD"],
        "mailing_lists" => [
          'rubyonrails-security@googlegroups.com'
        ],
        "email_to" => [ra.user.email]

      }
      runner.add_checker(GemsStatus::NotASecurityAlertChecker.new(conf))
      runner.execute
      puts "DEBUG: ------- Inserting into database -----------------"
      puts "DEBUG: Inserting gems"
      runner.gem_list.each do |name, gem|
        puts "DEBUG: #{name}"
        if !RubyGem.exists?(:name => gem.name, :version => gem.version.to_s)
          rg = RubyGem.new
          rg.name = gem.name
          rg.version = gem.version.to_s
          rg.license = gem.license
          rg.ruby_applications = [ra]
          rg.save
        else
          rg = RubyGem.find_by(:name => gem.name, :version => gem.version.to_s)
          rg.ruby_applications << ra unless rg.ruby_applications.include? ra
        end
      end
      puts "DEBUG: Inserting alerts"
      runner.checker_results.each do |_, alerts|
        alerts.each do |alert|
          gem = alert.gem
          puts "DEBUG: Adding alert for #{gem.name}"
          rg = RubyGem.find_by(:name => gem.name, :version => gem.version.to_s)
          if rg.nil?
            puts "ERROR: I could not find #{gem.name} : #{gem.version.to_s}"
            exit -1
          end
          next if SecurityAlert.exists?(:desc => alert.description, :ruby_gem_id => rg.id, :ruby_application_id => ra.id)
          sa = SecurityAlert.new
          sa.desc = alert.description.truncate(250)
          sa.ruby_gem = rg
          sa.ruby_application = ra
          sa.version_fix = ""
          sa.status = 0
          sa.comment = ""
          sa.save
        end
      end
    end
    lr = LastRun.new
    lr.save
  end
end
