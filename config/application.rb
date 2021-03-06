require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OpinionatedRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.app_name = Module.nesting.last.name
    config.hostname = "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" || ENV['HOST_NAME'] || 'app.example.com'
    config.email_domain = config.hostname
    config.email_sender = "noreply@#{config.email_domain}"
  end
end
