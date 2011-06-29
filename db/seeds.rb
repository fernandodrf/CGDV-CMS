# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

#Catalogo Diagnosticos
FasterCSV.foreach("#{RAILS_ROOT}/db/catalogos/diagnosticos.csv") do |row|
 if CatalogoDiagnostico.create(:diagnostico => row[0].to_s)
 	puts "Diagnostico: #{row} cargado."
 else
 	puts "Error al cargar #{row}."
 end
end

#Catalogo de Derechohabientes
#CatalogoDerechohabiente.create!(:seguro => "IMSS")
#CatalogoDerechohabiente.create!(:seguro => "ISSSTE")
#CatalogoDerechohabiente.create!(:seguro => "Sedena")
#CatalogoDerechohabiente.create!(:seguro => "Beneficencia")
#CatalogoDerechohabiente.create!(:seguro => "Sector Salud Estatal")
#CatalogoDerechohabiente.create!(:seguro => "Semar")
#CatalogoDerechohabiente.create!(:seguro => "Privado")
#CatalogoDerechohabiente.create!(:seguro => "SSGDF")
#CatalogoDerechohabiente.create!(:seguro => "SSA")
#CatalogoDerechohabiente.create!(:seguro => "Otros")
#CatalogoDerechohabiente.create!(:seguro => "ISSEMYM")
#CatalogoDerechohabiente.create!(:seguro => "Seguro Popular")