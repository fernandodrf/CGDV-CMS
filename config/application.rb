require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cgdv
  class Application < Rails::Application
	# Enable the asset pipeline
	config.assets.enabled = true
 
	# Version of your assets, change this if you want to expire all your assets
	config.assets.version = '1.0'

    # ! Remove in Rails > 5.0
    # For not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.errors_in_transactional_callbacks = true
    config.active_record.raise_in_transactional_callbacks = true

	# Change the path that assets are served from
	# config.assets.prefix = "/assets"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Mexico City'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # CONFIGS in: initializers locale.rb

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # ---- Rspec config for testing ----
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
    end
    # ---- Rspec config for testing ----
  end
end
