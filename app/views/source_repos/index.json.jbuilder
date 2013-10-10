json.array!(@source_repos) do |source_repo|
  json.extract! source_repo, :name, :url
  json.url source_repo_url(source_repo, format: :json)
end
