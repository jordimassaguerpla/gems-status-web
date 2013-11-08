require "yaml"

namespace :gems_status do
  desc "Import source repos from tmp/security_alerts.yml"
  task :import_security_alerts => :environment do
    data = YAML::load_file(open("tmp/security_alerts.yml"))
    data.each do |fixed|
      key = fixed.first
      version = fixed.second
      puts "read #{key} #{version}"
      SecurityAlert.all.each do |sa|
        if sa.desc.include? key
          puts "Key found in #{sa.id}"
          if version == "0.0.0"
            puts "let's ignore it..."
            sa.status = 2
          else
            puts "let's mark as fixed..."
            sa.status = 1
            sa.version_fix = version
          end
          sa.save
          break
        end
      end
    end
  end
end

