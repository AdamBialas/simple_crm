require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crm2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.time_zone = 'Europe/Warsaw'
    config.active_record.default_timezone = :local
    config.load_defaults 6.1
    config.hosts << 'wsl_host'
    config.web_console.whitelisted_ips = %w[0.0.0.0/0 ::/0]
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
