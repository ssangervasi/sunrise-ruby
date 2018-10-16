require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Clockwork
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Default anyway
    # config.time_zone = 'UTC'

    # config.time_zone = 'America/Los_Angeles'
    # config.time_zone = 'America/New_York'
  end
end
