require "gems_status_wrapper"

namespace :gems_status do
  desc "Run gems-status"
  task :run => :environment do
    RubyApplication.all.each do |ra|
      GemsStatusWrapper.new.run(ra)
    end
  end
end
