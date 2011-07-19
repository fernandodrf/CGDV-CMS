# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Corregir para ruby 1.9.2

#Catalogo Diagnosticos
require 'csv'
CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/diagnosticos.csv", 'r')) do |row|
 if CatalogoDiagnostico.create(:diagnostico => row[0].to_s)
 	#puts row[0]
 else
 	puts "Error al cargar #{row[0]}"
 end
end

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