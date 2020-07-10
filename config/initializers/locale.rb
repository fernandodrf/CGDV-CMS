# config/initializers/locale.rb
# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
 
# Permitted locales available for the application
I18n.available_locales = ['es-MX', :en]
 
# Set default locale to something other than :en
I18n.default_locale = 'es-MX'

# So Faker does not break while running specs
# Faker::Config.locale = 'en' 