RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  config.before(:each, type: :system, js: true) do
    # it could be  :selenium_chrome_headless but it does not works on WSL
    driven_by :selenium_headless
  end
end