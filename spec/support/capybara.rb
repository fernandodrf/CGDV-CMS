require 'selenium/webdriver'

local_chromedriver = ENV['CHROMEDRIVER_PATH']
if local_chromedriver.nil? || local_chromedriver.empty?
  local_chromedriver = '/usr/bin/chromedriver'
end

if defined?(Selenium::WebDriver::Chrome::Service) && File.executable?(local_chromedriver)
  # Avoid webdrivers network fetches (and local CA/proxy SSL issues) when a local chromedriver exists.
  Selenium::WebDriver::Chrome::Service.driver_path = local_chromedriver
end

use_chrome_for_js_system_specs = ENV['CHROMEDRIVER_PATH'] && !ENV['CHROMEDRIVER_PATH'].empty?

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  config.before(:each, type: :system, js: true) do
    # Default keeps legacy behavior (:selenium_headless -> Firefox). Set CHROMEDRIVER_PATH to force Chrome.
    if use_chrome_for_js_system_specs
      driven_by :selenium_chrome_headless
    else
      # it could be :selenium_chrome_headless but it does not works on WSL
      driven_by :selenium_headless
    end
  end
end
