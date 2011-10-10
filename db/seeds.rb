# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Corregir para ruby 1.9.2

require 'csv'
=begin
#Catalogo Paises
CSV.foreach("#{RAILS_ROOT}/db/catalogos/paises.txt") do |row|
 if CatalogoCountry.create(:country => row[0].to_s)
 	#puts "Cargado Pais: #{row[0].to_s}"
 else
 	puts "Error al cargar: #{row[0].to_s}"
 end
end
puts "Cargado Catalogo Paises"


#Revisar Pacientes
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients.csv", "r")) do |row|

  #Informacion basica
  #Revisa oldid Paciente
 #if row[0].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[0]}"
    #break
  #end
 
  if row[11].to_date
  	puts "#{row[11]} #{row[11].to_date}"
  end
  
  if row[9].to_date
  	puts "#{row[9]} #{row[9].to_date}"
  end
  
  #Telefonos
  if row[12].match(/\D/)
    puts "Error id: #{row[0]} Telefono #{row[12]}"
  end

  #Comentarios
  if row[8].match(/\\N/)
    puts "Error id: #{row[0]} Comentario #{row[8]}"
  end
 
  #Domicilio
  if row[1].match(/\\N/) 
    #puts "#{row[1]} #{row[2]}"
    cp  = 0
    if row[2].match(/\\N/)
      cp = row[2]
    end
    puts "Error id: #{row[0]} Domicilio #{row[1]} CP:#{cp}"
  end
 
 
  #Domicilio Alterno
  if row[7].match(/\\N/) 
    cp  = 0
    puts "Error id: #{row[0]} Domicilio Alterno #{row[7]}"
  end   
end


#Cargar Pacientes
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients.csv", 'r')) do |row|

  #Nuevo Paciente
  p = Patient.new
  
  p.oldid = "#{row[0]}"
  p.name = "#{row[3]} #{row[4]}"
  p.cgdvcode = row[10]
  p.sex = "#{row[5]}"
  p.blod = "#{row[6]}"
  p.birthdate = !row[11].match(/\\N/) ? row[11].to_date : Time.now.to_date
  p.created_at = !row[9].match(/\\N/) ? row[9].to_date : Time.now.to_date
  
  #Si no puede salvar le paciente
  if !p.save
    puts "Error en Paciente con id: #{row[0]}"
  	break
  end
  
  #Telefonos
  if !row[12].match(/\D/)
    if !p.telephones.create(:place => "Principal", :number => row[12])
      puts "Error en Paciente con id: #{row[0]} Telefono #{row[12]}"
  	  break
  	end
  end
  
  #Comentarios
  if !row[8].match(/\\N/)
    if !p.comments.create(:comment => row[8].to_s)
      puts "Error en Paciente con id: #{row[0]} Comentario #{row[8]}"
  	  break
  	end
  end
 
  #Domicilio
  if !row[1].match(/\\N/) 
    #puts "#{row[1]} #{row[2]}"
    cp  = 0
    if !row[2].match(/\\N/)
      cp = row[2]
    end
    if !p.addresses.create(:place => "Principal", :codigopostal => cp, :estado => ".", :municipio => ".", :colonia => ".", :domicilio => row[1])
      puts "Error en Paciente con id: #{row[0]} Domicilio #{row[1]} #{row[2]}" 
  	  break
  	end
  end

  #Domicilio Alterno
  if !row[7].match(/\\N/) 
    cp  = 0
    if !p.addresses.create(:place => "Alterno", :codigopostal => cp, :estado => ".", :municipio => ".", :colonia => ".", :domicilio => row[7])
      puts "Error en Paciente con id: #{row[0]} Domicilio Alterno #{row[7]}"
  	  break
  	end
  end  
  
end
puts "Todos los Pacientes Cargados"


#Familiares
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients_fam.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients_fam.csv", "r")) do |row|
	
  FAM = ['Padre o Madre', 'Herman@', 'Hij@', 'Conyuge', 'Ti@', 'Sobrin@', 'Otr@', 'No se Sabe']

  #Revisa oldid Paciente
  #if row[0].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[0]}"
    #break
  #end 
  
  p = Patient.find_by_oldid(row[0])
  if p.nil?
  	puts "Patient NIL"
  	puts row[0]
  	break
  end

  #Informacion basica
  #detecta el parentesco y lo fija
  parentesco = !row[2].match(/\D/) ? FAM[row[2].to_i-1] : FAM[7]
  #Nombre
  nombre = row[3].match(/\\N/)||row[4].match(/\\N/) ? "Desconocido" : "#{row[3]} #{row[4]}"
  #Edad
  edad = !row[5].match(/\\N/) ? row[5] : 0
  #Comentarios
  comentarios = !row[6].match(/\\N/) ? row[6] : "."
  #Derechohabiente
  derechohabiente = 'No se Sabe'
  
  #Si no puede salvar el Familiar
  if !p.family_members.create(:parentesco => parentesco,
  							  :nombre => nombre,
  							  :edad => edad,
  							  :comentarios => comentarios,
  							  :derechohabiente => derechohabiente)
    puts "Error en Familiar con id: #{row[0]}"
    break
  end
  #puts "Familiar con id: #{row[0]} #{row[3]} #{row[4]} aniadido"
end
puts "Todos los familiares cargados"

#Habitacion
#num_habitaciones, tipo, num_habitantes, num_familiares, menores, economica_activas, idpaciente
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients_hab.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients_hab.csv", "r")) do |row|
	
  TIPOS = ['Albergue', 'Alquiler', 'Prestada', 'Rentada', 'Propia', 'Institucion Medica', 'Sin Vivienda', 'No se Sabe']

  #Revisa oldid Paciente
  #if row[6].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[6]}"
    #break
  #end   
  
  p = Patient.find_by_oldid(row[6])
  if p.nil?
  	puts "Patient NIL"
  	puts row[6]
  	break
  end

  #Informacion basica
  #detecta el numero de habitaciones y lo fija
  habitaciones = !row[0].match(/\D/) ? row[0].to_i : 0
  #detecta el tipo de habitacion y lo fija
  tipo = !row[1].match(/\D/) ? TIPOS[row[1].to_i-1] : TIPOS[7]
  #Habitantes
  habitantes = !row[2].match(/\D/) ? row[2].to_i : 0
  #Familiares
  familiares = !row[3].match(/\D/) ? row[3].to_i : 0
  #Menores
  menores = !row[4].match(/\D/) ? row[4].to_i : 0
  #EconAct
  ecoact = !row[5].match(/\D/) ? row[5].to_i : 0  
  
  #Si no puede salvar el House
  if !p.create_house(:habitaciones => habitaciones,
  				    :tipo => tipo,
  				    :habitantes => habitantes,
  				    :familiares => familiares,
  				    :menores => menores,
  				    :economicaactivas => ecoact)
    puts "Error en Habitacion con id: #{row[6]}"
    break
  end
end
puts "Todos los datos de Habitacion cargados"

#Socioeconomico
#num_televisiones, num_vehiculos, nivel_socioeco, idpaciente, servicios_urbanos, television_paga, sgmm
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients_socioeco.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients_socioeco.csv", "r")) do |row|
    
  #Revisa oldid Paciente
  #if row[3].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[3]}"
    #break
  #end    
    
  p = Patient.find_by_oldid(row[3])
  if p.nil?
  	puts "Patient NIL"
  	puts row[3]
  	break
  end

  #Informacion basica
  #detecta el numero de tvs y lo fija
  tvs = !row[0].match(/\D/) ? row[0].to_i : 0
  #detecta el tipo de vehiculos y lo fija
  vehiculos = !row[1].match(/\D/) ? row[1].to_i : 0
  #nivel
  nivel = !row[2].match(/\D/) ? row[2].to_i : 0
  #servicios
  servicios = !row[4].match(/[^A-Z\d]/) ? row[4].to_s : "No se Sabe"
  #puts servicios
  #tvpaga
  tvpaga = !row[5].match(/[^A-Z\d]/) ? row[5].to_s : "No se Sabe"
  #puts tvpaga
  #SGMM
  sgmm = !row[6].match(/[^A-Z\d]/) ? row[6].to_s : "No se Sabe" 
  #puts sgmm
  
  #Si no puede salvar el Socioeco
  if !p.create_socioeco(:ingresos => 0,
  					   :gastos => 0,
  					   :televisiones => tvs,
  					   :vehiculos => vehiculos,
  					   :nivel => nivel,
  					   :serviciosurbanos => servicios,
  					   :televisionpaga => tvpaga,
  					   :sgmm => sgmm)
    puts "Error en Socioeconomicos con id: #{row[3]}"
    break
  end
end
puts "Todos los datos Socioeconomicos cargados"

#Ingresos
#ingreso_familiar, gastos_manutencion, idpaciente
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients_ing.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients_ing.csv", "r")) do |row|
    
  #Revisa oldid Paciente
  #if row[2].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[2]}"
    #break
  #end    
    
  p = Patient.find_by_oldid(row[2])
  if p.nil?
  	puts "Patient NIL"
  	puts row[2]
  	break
  end

  #Informacion basica
  #ingreso
  ingreso = !row[0].match(/\D/) ? row[0].to_i : 0
  #puts ingreso
  #gastos
  gastos = !row[1].match(/\D/) ? row[1].to_i : 0
  #puts gastos
  
  #Verificar si existe socioeco
  if p.socioeco.nil?
    #Si no puede salvar el Socioeco
    if !p.create_socioeco(:ingresos => ingreso,
  					   :gastos => gastos,
  					   :televisiones => 0,
  					   :vehiculos => 0,
  					   :nivel => 0,
  					   :serviciosurbanos => 'NO',
  					   :televisionpaga => 'NO',
  					   :sgmm => 'NO')
    puts "Error en Ingresos con id: #{row[2]}"
      break
    end
  else
  	#puts "Actualizando Socioeco con id: #{row[2]}"
    if !p.socioeco.update_attributes(:ingresos => ingreso, :gastos => gastos)
      puts "Error en Ingresos con id: #{row[2]}"
      break
    end
  end
end
puts "Todos los datos de Ingresos cargados"

#Referencia Clinica
CSV.foreach("#{RAILS_ROOT}/db/catalogos/patients_refclinica.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/patients_refclinica.csv", "r")) do |row|
  
  DH = ['IMSS','ISSSTE','Sedena','No Tiene','Beneficencia','Sec Salud Estatal','Semar','Privado','SSGDF','SSA','Otros','ISSEMYM', 'No se Sabe']
  
  #Revisa oldid Paciente
  #if row[0].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[0]}"
    #break
  #end    
    
  p = Patient.find_by_oldid(row[0])
  if p.nil?
  	puts "Patient NIL"
  	puts row[0]
  	break
  end

  #Informacion Afiliacion
  #iddh
  seguro = !row[1].match(/\D/) ? DH[row[1].to_i-1] : DH[12]
  #afiliacion
  afiliacion = !row[2].match(/\\N/) ? row[2].to_s : '---'
  
  #Crea derechohabiente
  if !p.derechohabientes.create(:seguro => seguro, :afiliacion => afiliacion)
    puts "Error al aniadir DH de #{row[0]}"
    break
  end

  diagnostico = !row[5].match(/\\N/) ? row[5].to_s : '---'
  #Diagnostico
  if !p.diagnosticos.create(:diagnostico => diagnostico)
  	puts "Error al aniadir Diagnostico: #{diagnostico} de: #{row[0]}"
    break
  end
  
  tipo = !row[6].match(/\\N/) ? row[6].to_s : '---'
  #Tratamiento
  if !p.tratamientos.create(:tipo => tipo)
  	puts "Error al aniadir Tratamiento: #{tipo} de #{row[0]}"
    break
  end  
  
  #idpaciente	iddh	afiliacion	hospital	nombre_medico	diagnostico	tratamiento	remite	fecha_referencia	aceptado	otras_ayudas	apoyo
  hospital = !row[3].match(/\\N/) ? row[3].to_s : '---'
  medico = !row[4].match(/\\N/) ? row[4].to_s : '---'
  referencia = !row[8].match(/\\N/) ? row[8].to_date : Time.now.to_date
  aceptado = !row[9].match(/\\N/) ? row[9].to_s : 'No se Sabe'
  ayudas = !row[11].match(/\\N/) ? row[11].to_s : '---'
  
  #Crear referencia clinica
  if !p.create_refclinica(:hospital => hospital,
  						 :medico => medico,
  						 :referencia => referencia,
  						 :aceptado => aceptado,
  						 :ayudas => ayudas)
    puts "Error al crear Referencia Clinica de #{row[0]}"
  end

end
puts "Todos las Referencias Clinicas cargadas"


#Notas
#idpaciente	idnota	subtotal	total	adeudo	acuenta	restan	fecha_registro
CSV.foreach("#{RAILS_ROOT}/db/catalogos/notas.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/notas.csv", "r")) do |row|
    
  #Revisa oldid Paciente
  #if row[0].to_s.match(/[^A-Z\d]/)
    #puts "Acentos o Caracteres Raros, revisar archivo"
    #puts "#{row[0]}"
    #break
  #end    
    
  p = Patient.find_by_oldid(row[0])
  if p.nil?
  	puts "Patient NIL"
  	puts row[0]
  	break
  end
  
  #Informacion basica
  #folio
  folio = !row[1].match(/\D/) ? row[1].to_i : 0

  if row[1].to_s.match(/\D/)
    puts "Error de Folio #{row[1]}"
  end  

  #subtotal
  subtotal = !row[2].match(/\D/) ? row[2].to_f : 0
  #total
  total = !row[3].match(/\D/) ? row[3].to_f : 0
  #adeudo
  adeudo = !row[4].match(/\D/) ? row[4].to_f : 0
  #acuenta
  acuenta = !row[5].match(/\D/) ? row[5].to_f : 0
  #restan
  restan = !row[6].match(/\D/) ? row[6].to_f : 0
  #fecha_registro
  reg = !row[7].match(/\\N/) ? row[7].to_date : Time.now.to_date

  #Si no puede salvar el Socioeco
  if !p.notes.create(:folio => folio,
  					:adeudo => adeudo,
  					:acuenta => acuenta,
  					:restan => restan,
  					:subtotal => subtotal,
  					:total => total,
  					:fecha => reg)
    puts "Error en Notas con id: #{row[0]}"
    break
  end
end
puts "Todas las Notas cargadas"


#Notas Elementos
#idnota,codigo,cantidad,cuota,descripcion
CSV.foreach("#{RAILS_ROOT}/db/catalogos/notas_elem.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/notas_elem.csv", "r")) do |row|
     
  n = Note.find_by_folio(row[0])
  if n.nil?
  	puts "Nota NIL"
  	puts row[0]
  	break
  end
  
  #Informacion basica
  #codigo
  codigo = !row[1].match(/\\N/) ? row[1].to_s : '0'
  #cantidad
  cantidad = !row[2].match(/\D/) ? row[2].to_i : 0
  #cuota
  cuota = !row[3].match(/\D/) ? row[3].to_f : 0
  #descripcion
  descripcion = !row[4].match(/\\N/) ? row[4].to_s : '---'
  
  #Si no se puede salvar el Elemento de la nota
  if !n.elements.create(:codigo => codigo,
  					   :cantidad => cantidad,
  					   :cuota => cuota,
  					   :descripcion => descripcion)
    puts "Error en Elementos de Notas con id: #{row[0]}"
    break
  end
end
puts "Todas los Elementos de Notas cargados"


#Admin
admin = User.create!(:name => "Demo", :email => "test@example.com", :password => "tecolote", :password_confirmation => "tecolote", :language =>"en")
admin.toggle!(:admin)

#Catalogo Diagnosticos
CSV.foreach("#{RAILS_ROOT}/db/catalogos/diagnosticos.csv") do |row|
#CSV::Reader.parse(File.open("#{RAILS_ROOT}/db/catalogos/diagnosticos.csv", 'r')) do |row|
 if CatalogoDiagnostico.create(:diagnostico => row[0].to_s)
 	#puts "Cargado Diagnostico: #{row[0].to_s}"
 else
 	puts "Error al cargar: #{row[0].to_s}"
 end
end
puts "Cargado Catalogo Diagnosticos"

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

=end