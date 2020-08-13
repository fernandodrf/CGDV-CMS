RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  config.before(:each, type: :system, js: true) do
    driven_by :selenium_headless
    page.driver.browser.manage.window.resize_to(1280,1280) # to set any window size.
  end
end
