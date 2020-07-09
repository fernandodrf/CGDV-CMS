# config/initializers/locale.rb
 
# Permitted locales available for the application
I18n.available_locales = [:sp, :es, :en]
 
# Set default locale to something other than :en
I18n.default_locale = :sp

# So Faker does not break while running specs
# Faker::Config.locale = 'en' 