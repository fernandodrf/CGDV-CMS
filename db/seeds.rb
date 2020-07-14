# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Corregir para ruby 1.9.2

require 'csv'

#Catalogo Paises
CSV.foreach(Rails.root.join('db/catalogos/paises.txt')) do |row|
 if CatalogoCountry.create(:country => row[0].to_s)
 	#puts "Cargado Pais: #{row[0].to_s}"
 else
 	puts "Error al cargar: #{row[0].to_s}"
 end
end
puts "Cargado Catalogo Paises"

# #Catalogo Diagnosticos
# CSV.foreach("#{RAILS_ROOT}/db/catalogos/diagnosticos.csv") do |row|
# #CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/diagnosticos.csv", 'r')) do |row|
#  if CatalogoDiagnostico.create(:diagnostico => row[0].to_s)
#  	#puts "Cargado Diagnostico: #{row[0].to_s}"
#  else
#  	puts "Error al cargar: #{row[0].to_s}"
#  end
# end
# puts "Cargado Catalogo Diagnosticos"

#Catalogo de Derechohabientes
CatalogoDerechohabiente.create(:seguro => "IMSS") ? true : puts("Error al cargar IMSS")
CatalogoDerechohabiente.create(:seguro => "ISSSTE") ? true : puts("Error al cargar ISSSTE")
CatalogoDerechohabiente.create(:seguro => "Sedena") ? true : puts("Error al cargar Sedena")
CatalogoDerechohabiente.create(:seguro => "Beneficencia") ? true : puts("Error al cargar Beneficencia")
CatalogoDerechohabiente.create(:seguro => "Sector Salud Estatal") ? true : puts("Error al cargar Sector Salud Estatal")
CatalogoDerechohabiente.create(:seguro => "Semar") ? true : puts("Error al cargar Semar")
CatalogoDerechohabiente.create(:seguro => "Privado") ? true : puts("Error al cargar Privado")
CatalogoDerechohabiente.create(:seguro => "SSGDF") ? true : puts("Error al cargar SSGDF")
CatalogoDerechohabiente.create(:seguro => "SSA") ? true : puts("Error al cargar SSA")
CatalogoDerechohabiente.create(:seguro => "Otros") ? true : puts("Error al cargar Otros")
CatalogoDerechohabiente.create(:seguro => "ISSEMYM") ? true : puts("Error al cargar ISSEMYM")
CatalogoDerechohabiente.create(:seguro => "Seguro Popular") ? true : puts("Error al cargar Seguro Popular")
puts "Cargado Catalogo de Derechohabientes"


Catestado.create(:estado => 'Aguascalientes')
Catestado.create(:estado => 'Baja California')
Catestado.create(:estado => 'Baja California Sur')
Catestado.create(:estado => 'Campeche')
Catestado.create(:estado => 'Chiapas')
Catestado.create(:estado => 'Chihuahua')
Catestado.create(:estado => 'Coahuila')
Catestado.create(:estado => 'Colima')
Catestado.create(:estado => 'Distrito Federal')
Catestado.create(:estado => 'Durango')
Catestado.create(:estado => 'Estado de Mexico')
Catestado.create(:estado => 'Guanajuato')
Catestado.create(:estado => 'Guerrero')
Catestado.create(:estado => 'Hidalgo')
Catestado.create(:estado => 'Jalisco')
Catestado.create(:estado => 'Michoacan')
Catestado.create(:estado => 'Morelos')
Catestado.create(:estado => 'Nayarit')
Catestado.create(:estado => 'Nuevo Leon')
Catestado.create(:estado => 'Oaxaca')
Catestado.create(:estado => 'Puebla')
Catestado.create(:estado => 'Queretaro')
Catestado.create(:estado => 'Quintana Roo')
Catestado.create(:estado => 'San Luis Potosi')
Catestado.create(:estado => 'Sinaloa')
Catestado.create(:estado => 'Sonora')
Catestado.create(:estado => 'Tabasco')
Catestado.create(:estado => 'Tamaulipas')
Catestado.create(:estado => 'Tlaxcala')
Catestado.create(:estado => 'Veracruz')
Catestado.create(:estado => 'Yucatan')
Catestado.create(:estado => 'Zacatecas')
Catestado.create(:estado => 'Fuera de Mexico')
Catestado.create(:estado => 'Otro')