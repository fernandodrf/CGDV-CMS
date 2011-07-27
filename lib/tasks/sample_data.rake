#Populates development enviroment

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
  	
  	#faker gem only in development enviroment
  	require 'faker'
  	
  	#Create admin
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Demo",
                 :email => "test@example.com",
                 :password => "tecolote",
                 :password_confirmation => "tecolote",
                 :language =>"en")
    admin.toggle!(:admin)
    #Create fake users
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
    #Create fake patients
    100.times do |n|
      name  = Faker::Name.name
      cgdvcode = "#{n+1}"
      sex = 'M'
      birthdate = Time.now
      blod = 'NS'
      Patient.create!(:name => name,
                   :cgdvcode => cgdvcode,
                   :sex => sex,
                   :birthdate => birthdate,
                   :blod => blod)
    end
    Patient.all.each do |patient|
      phone = Faker::PhoneNumber.phone_number
      patient.telephones.create!(:place => "Casa", :number => phone)
      phone = Faker::PhoneNumber.phone_number
      patient.telephones.create!(:place => "Trabajo", :number => phone)
    end
  end
end
