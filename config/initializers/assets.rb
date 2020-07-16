# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( logo.jpg blueprint/screen.css blueprint/print.css blueprint/ie.css jquery-ui.css autocomplete-rails.js jquery.textareaCounter.plugin.js nested_form.js customprint.css event_calendar.js event_calendar.css )
