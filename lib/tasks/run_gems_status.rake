require "gems_status_wrapper"

namespace :gems_status do
  desc "Run gems-status"
  task :run => :environment do
    RubyApplication.all.each do |ra|
      ra.delay.run_report
    end
  end
end
