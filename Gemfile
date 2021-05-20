source 'http://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 2.7.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
# User authentication
gem "devise", "~> 4.7"
# Pagination
gem "kaminari"#, "~> 1.2"
# Search
gem 'ransack'#, '~> 1.8'

gem 'cancancan'#, '~> 1.17'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

gem 'travis'

# For Roles, use with CanCan
# FIXME: Migrate to Rolify
# gem "easy_roles", "~> 1.2.0"
# gem 'easy_roles', git: 'https://github.com/aarona/easy_roles.git'
# Requires Rails >= 6.0
gem "slow_your_roles"

# Use rails-i18n for internacionalization
gem 'rails-i18n', '~> 6.0.0'

gem 'devise-i18n'

# Use Puma as the app server
gem 'puma', '~> 4.3'

# FIXME: Needs to go eventually
gem "nested_form"

gem "rails-jquery-autocomplete"

# Update with Rails > 5.0
# Still a good alternative to ActiveStorage
gem "carrierwave", "~> 2"

# !! Instalar ImageMagick or GraphicsMagick
gem 'mini_magick'#, '~> 3.3'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Maintenance Mode
gem 'turnout'
# ?? https://nokogiri.org
gem 'nokogiri'

# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '~> 5'

# Use jquery as the JavaScript library
gem 'jquery-rails'#, '~> 2.0'
gem 'jquery-ui-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 1.1', group: :doc

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.7', require: false

# EverydayRailsRspec
group :development, :test do
  gem "rspec-rails",  "~> 4"
  gem "factory_bot_rails"#,  "~> 5"

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'rails-controller-testing' # If you are using Rails 5.x

  # Generate faster factories
  # no dependencies
  gem "faker", "~> 2"
  # Great to generate fast specs
  gem 'shoulda-matchers'#, '~> 4'
  # depends on rspec
  gem "capybara"#, "~> 2.15.2"
  gem 'capybara-email'
  #  capybara >= 1.0, < 4
  # gem 'capybara-screenshot', '~> 1.0.24'
  gem 'webdrivers'
  # no deps
  gem "launchy"#, "~> 2.2.0"

  # Test coverage
  gem 'simplecov'#, '~> 0.17.0', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  #  activerecord <= 4.3, >= 3.2
  gem 'annotate'#, '~> 2.6'
  # gem "nifty-generators", "~> 0.4.6"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
