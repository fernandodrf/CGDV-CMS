#Populates development enviroment
namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
  	require 'faker'
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Demo",
                 :email => "test@example.com",
                 :password => "tecolote",
                 :password_confirmation => "tecolote",
                 :language =>"en")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "test#{n+1}@example.com"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :language =>"sp")
    end
    100.times do |n|
      name  = Faker::Name.name
      cgdvcode = "#{n+1}"
      Patient.create!(:name => name,
                   :cgdvcode => cgdvcode)
    end
  end
end
