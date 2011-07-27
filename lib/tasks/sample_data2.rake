#Populates development enviroment

namespace :db do
  desc "Fill database with sample data"
  task :onepopulate => :environment do
  	
  	#faker gem only in development enviroment
  	require 'faker'
  	
  	#Create admin
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Demo Admin",
                 :email => "test@example.com",
                 :password => "tecolote",
                 :password_confirmation => "tecolote",
                 :language =>"sp")
    admin.toggle!(:admin)

    #Create fake patients
    1.times do |n|
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
    #Añadir Datos de mas
    Patient.all.each do |patient|
      #Referencia Clinica
      patient.create_refclinica(:hospital => "H General", :medico => "Dr. Villemon Cuasar", :referencia => Time.now, :aceptado => "Alfonso Aguilar", :ayudas => "Ninguna")
      #2 telefonos
      phone = Faker::PhoneNumber.phone_number
      patient.telephones.create!(:place => "Casa", :number => phone)
      phone = Faker::PhoneNumber.phone_number
      patient.telephones.create!(:place => "Trabajo", :number => phone)
      #Direccion
      patient.addresses.create!(:place => "Casa", :codigopostal => '98761', :estado => "Estado de Mexico", :municipio => "Toluca", :colonia => "El alfalfar", :domicilio => Faker::Address.street_address)
      #Derechohabiente
      patient.derechohabientes.create!(:seguro => "IMSS", :afiliacion => "22121/1-AFA")
      patient.derechohabientes.create!(:seguro => "ISSSTE", :afiliacion => "WEMT19468")
      #Apoyos
      patient.apoyos.create!(:tipo => "Medicamento")
      patient.apoyos.create!(:tipo => "Transplante de Medula Osea")
      #Tratamientos
      patient.tratamientos.create!(:tipo => "Qt")
      patient.tratamientos.create!(:tipo => "Rt")
      #Diagnosticos
      patient.diagnosticos.create!(:diagnostico => "Tumor de Askin")
      #Informacion de Vivienda
      patient.create_house(:habitaciones => '2', :tipo => 'Rentada', :habitantes => '4', :familiares => '6', :menores => '2', :economicaactivas => '2')
      #Informacion Socioeconomica
      patient.create_socioeco(:ingresos => '3450', :gastos => '3000', :televisiones => '1', :vehiculos => '0', :nivel => '1', :serviciosurbanos => 'Si', :televisionpaga => 'No', :sgmm => 'No')
      #Familiares
      patient.family_members.create!(:parentesco => 'Padre', :nombre => Faker::Name.name, :edad => '55', :derechohabiente => 'Ninguno')
      patient.family_members.create!(:parentesco => 'Herman@', :nombre => Faker::Name.name, :edad => '30', :derechohabiente => 'IMSS', :comentarios => 'Autista')
      #Comentarios
      patient.comments.create!(:comment => 'Paciente Demo, cargar informacion basada en este modelo')
    end
  end
end
