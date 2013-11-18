require "gems_status_wrapper"

namespace :gems_status do
  desc "Run gems-status"
  task :run => :environment do
    GemsStatusWrapper.new.run
  end
end
