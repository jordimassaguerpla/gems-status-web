if CONFIG['GITHUB_KEY'] && CONFIG['GITHUB_SECRET']
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, CONFIG['GITHUB_KEY'], CONFIG['GITHUB_SECRET'], scope: "user:email"
  end
end

