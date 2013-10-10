require "yaml"

namespace :gems_status do
  desc "Import source repos from tmp/source_repos.yml"
  task :import_source_repos => :environment do
    data = YAML::load_file(open("tmp/source_repos.yml"))
    data["source_repos"].each do |name, url|
      sr = SourceRepo.find_or_create_by_name(name)
      sr.url = url
      sr.save
    end
  end
end
