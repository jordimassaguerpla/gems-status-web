require "yaml"

namespace :gems_status do
  desc "Import source repos from tmp/security_alerts.yml"
  task :import_security_alerts => :environment do
    data = YAML::load_file(open("tmp/security_alerts.yml"))
    data.each do |key, version|
      SecurityAlert.all.each do |sa|
        if sa.desc.include? key
          if version = "0.0.0"
            sa.status = 2
          else
            sa.status = 1
            sa.fixed_version = version
          end
          break
        end
      end
    end
  end
end
