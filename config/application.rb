require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

config_file = File.expand_path('../application.yml', __FILE__)
if File.exists?(config_file)
  CONFIG = YAML.load(File.read(config_file))
else
  CONFIG = {}
end

CONFIG["GMAIL_USERNAME"] = ENV["GMAIL_USERNAME"] if ENV["GMAIL_USERNAME"]
CONFIG["GMAIL_PASSWORD"] = ENV["GMAIL_PASSWORD"] if ENV["GMAIL_PASSWORD"]
CONFIG["MAILING_LISTS"] = ENV["MAILING_LISTS"] if ENV["MAILING_LISTS"]
CONFIG["MAX_RUBY_APP_BY_USER"] = ENV["MAX_RUBY_APP_BY_USER"].to_i if ENV["MAX_RUBY_APP_BY_USER"]
CONFIG["PARENT_SERVER"] = ENV["PARENT_SERVER"] if ENV["PARENT_SERVER"]
CONFIG["PARENT_SERVER_API_ACCESS_TOKEN"] = ENV["PARENT_SERVER_API_ACCESS_TOKEN"] if ENV["PARENT_SERVER_API_ACCESS_TOKEN"]
CONFIG['GOOGLE_ANALYTICS'] = ENV['GOOGLE_ANALYTICS'] if ENV['GOOGLE_ANALYTICS']
CONFIG['BUNDLE_GEMFILE'] = ENV['BUNDLE_GEMFILE'] if ENV['BUNDLE_GEMFILE']
CONFIG["NEW_RELIC_LICENSE_KEY"] = ENV["NEW_RELIC_LICENSE_KEY"] if ENV["NEW_RELIC_LICENSE_KEY"]
CONFIG["NEW_RELIC_APP_NAME"] = ENV["NEW_RELIC_APP_NAME"] if ENV["NEW_RELIC_APP_NAME"]
CONFIG['GITHUB_KEY'] = ENV['GITHUB_KEY'] if ENV['GITHUB_KEY']
CONFIG['GITHUB_SECRET']= ENV['GITHUB_SECRET'] if ENV['GITHUB_SECRET']
CONFIG['SERVER']= ENV['SERVER'] if ENV['SERVER']
CONFIG['FEEDBACK_LINK'] = ENV['FEEDBACK_LINK'] if ENV['FEEDBACK_LINK']
CONFIG['GITHUB_INTEGRATION'] = ENV['GITHUB_INTEGRATION'] if ENV['GITHUB_INTEGRATION']

module GemsStatusWeb
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
