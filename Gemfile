source 'http://rubygems.org'

gem 'rails', '4.1.16'
# User authentication
gem "devise", "~> 3.0.0"
# Pagination
gem "kaminari", "~> 0.17.0"
# Search
gem 'ransack', '~> 1.0'

gem 'cancancan'#, '~> 1.17'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.21'

# For Roles, use with CanCan
# FIXME: Migrate to Rolify
gem "easy_roles", "~> 1.2.0"

# Use rails-i18n for internacionalization
gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'rails-4-x' # For 4.x

gem 'devise-i18n'

# ---- Rails 4 Upgrade ----
# gem 'rails4_upgrade', github: 'alindeman/rails4_upgrade'
# Keep until all runs under Strong Parameters
# gem 'protected_attributes'
# ---- Rails 4 Upgrade ----

#Secret
#ENV Vars
gem "figaro"

#New Relic Monitoring
#gem 'newrelic_rpm'

# For ruby 2.3
gem 'test-unit', '~> 3.0'

# FIXME: Needs to go eventually
gem "nested_form"

# Requires Rails >= 6.0
# gem "slow_your_roles"

gem "rails-jquery-autocomplete"

gem "carrierwave", "~> 1.3.1"
# !! Instalar ImageMagick or GraphicsMagick 
gem 'mini_magick'#, '~> 3.3'

#Evento Calendar
gem 'event-calendar', :require => 'event_calendar'

# Maintenance Mode
gem 'turnout'
# ?? https://nokogiri.org
gem 'nokogiri'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 2.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
     
# To use debugger
# gem 'debugger'
# Use debugger
# gem 'debugger', group: [:development, :test]


# EverydayRailsRspec
group :development, :test do
  gem "rspec-rails",  "~> 3.9"
  gem "factory_bot_rails",  "~> 4.11.1"
end

group :test do
  # Generate faster factories
  # no dependencies
  gem "faker", "~> 1.9.3"
  # Great to generate fast specs
  # until rails 4.1
  gem 'shoulda-matchers', '~> 3.1'
  # depends on rspec
  gem "capybara"#, "~> 2.15.2"
  #  capybara >= 1.0, < 4 
  gem 'capybara-screenshot', '~> 1.0.24'
  # gem "database_cleaner", "~> 0.9.1"
  # no deps
  gem "launchy"#, "~> 2.2.0"

  # Test coverage
  gem 'simplecov'#, '~> 0.17.0', require: false
end

group :development do
  # gem 'mailcatcher'
  # Spring speeds up development by keeping your application running in the background. 
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  
  #  activerecord <= 4.3, >= 3.2 
  gem 'annotate', '~> 2.6'
  # gem "nifty-generators", "~> 0.4.6"
end

