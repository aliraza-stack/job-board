require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JobBoard
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # SMTP settings
    # config.action_mailer.delivery_method = :smtp
    # config.action_mailer.smtp_settings = {
    #   address: ENV['SMTP_ADDRESS'],
    #   port: ENV['SMTP_PORT'],
    #   domain: ENV['SMTP_DOMAIN'],
    #   user_name: ENV['SMTP_USER_NAME'],
    #   password: ENV['SMTP_PASSWORD'],
    #   authentication: ENV['SMTP_AUTHENTICATION'],
    #   enable_starttls_auto: true
    # }


  end
end
