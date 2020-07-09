source 'http://rubygems.org'

gem 'rails', '3.2.22.5'
gem 'bundler', '~> 1.17'
#gem 'rake', '~> 0.9.2'
gem "kaminari", "~> 0.17.0"
gem 'ransack', '~> 0.6.0'
gem 'jquery-rails', '~> 1.0.12'
gem 'cancan', '~> 1.6.5'
gem "pg", "~> 0.19"

gem 'rails4_upgrade', github: 'alindeman/rails4_upgrade'

#Secret
#ENV Vars
gem "figaro"

#New Relic Monitoring
#gem 'newrelic_rpm'

# For ruby 2.3
gem 'test-unit', '~> 3.0'

# For Rails 3.1
gem "nested_form"#, :git => "git://github.com/ryanb/nested_form.git"
gem "devise", "~> 1.4.4"
gem "easy_roles", "~> 1.2.0"
# Requires Rails >= 6.0
# gem "slow_your_roles"
gem "rails3-jquery-autocomplete", "~> 0.9.1"
gem "carrierwave", "~> 0.5.7"

#Evento Calendar
gem 'event-calendar', :require => 'event_calendar'

#Maintenance Mode
gem 'turnout'
gem 'nokogiri'

gem 'mini_magick', '~> 3.3'

#MiniMagick para Windows
# gem "hcatlin-mini_magick", "~> 1.3.1"

# Para evitar errores de Rails 3.1
# gem 'rack', '~> 1.3.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

# EverydayRailsRspec
group :development, :test do
  gem "rspec-rails",  "~> 3.9"
  gem "factory_bot_rails",  "~> 4.11.1"
end

group :test do
  # EverydayRailsRspec
  gem "faker", "~> 1.9.3"
  # Great to generate fast specs
  gem 'shoulda-matchers', '~> 2.8.0'
  gem "capybara", "~> 2.15.2"
  gem 'capybara-screenshot', '~> 1.0.24'
  gem "database_cleaner", "~> 0.9.1"
  gem "launchy", "~> 2.2.0"

  # Test coverage
  gem 'simplecov', '~> 0.17.0', require: false

  # Old ones
  gem "mocha"
end

group :development do
  gem 'thin'
  gem 'mailcatcher'
  gem 'scout_apm'
  gem 'annotate', '~> 2.4.0'
  gem "nifty-generators", "~> 0.4.6"
end

