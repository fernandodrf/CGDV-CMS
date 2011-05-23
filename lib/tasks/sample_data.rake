require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Demo",
                 :email => "test@example.com",
                 :password => "tecolote",
                 :password_confirmation => "tecolote")
    99.times do |n|
      name  = Faker::Name.name
      email = "faker_user-#{n+1}@example.com"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
