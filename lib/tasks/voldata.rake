namespace :db do
	
  desc "Update Volunteers"
  task :voldata => :environment do
    
  	require 'csv'
    Volunteer.destroy_all
    ###############################################
	CSV.foreach(Rails.root.join("db","catalogos","volyssdatos.txt"), :col_sep =>"\t") do |row|
	  status = row[14] == 'VOLUNTARIO' ? 2 : 1
	  prof = row[4] == "." ? "" : row[4]
	  name = "#{row[1]} #{row[2]}"
	  name = name.titleize
	  v = Volunteer.new(:oldid => "#{row[0]}", :name => name, :birth => "#{row[3]}",
	  					:cgdvcode => "#{row[18]}", :blood => "#{row[9]}", :sex => "NS", :status => status)
	  print v.valid? ? '' : v.errors
	  print v.valid? ? '' : v.oldid 	 
	  if v.valid?
	    v.save
	  end
	  #Info EXTRA
      sob = row[15] == 'SI' ? true : false
	  lic = row[16] == 'SI' ? true : false
	  efs = row[17] == 'SI' ? true : false
	  ev = Extravolunteer.new(:profesion => "#{row[4]}", :sobreviviente => sob, :licencia => lic,
	  						:exposferias => efs)
	  v.extravolunteers << ev
	  #Telefonos
	  #5: teltrabajo
	  #6: teldomicilio
	  #7: telcelular
	  teltrabajo = row[5]
	  t = v.telephones.new(:place => 'Trabajo', :number => teltrabajo)
	  (t.valid? and !t.number.eql?(".")) ? t.save : false
	  teldomicilio = row[6]
	  t = v.telephones.new(:place => 'Domicilio', :number => teldomicilio)
	  (t.valid? and !t.number.eql?(".")) ? v.telephones << t : false
	  telcelular = row[7]
	  t = v.telephones.new(:place => 'Celular', :number => telcelular)
	  (t.valid? and !t.number.eql?(".")) ? v.telephones << t : false
	  #8: Email
	  email = row[8]
	  e = v.emails.new(:email => email)
	  (e.valid? and !e.email.eql?(".")) ? v.emails << e : false
	  #10: Diagnostico
	  comentario = row[10]
	  c = v.comments.new(:comment => comentario)	  				
	  (c.valid? and !c.comment.eql?(".")) ? v.comments << c : false
	  #11: Comentarios
	  comentario = row[11]
	  c = v.comments.new(:comment => comentario)	  				
	  (c.valid? and !c.comment.eql?(".")) ? v.comments << c : false
	  #12: CP
	  #13: Domicilio
	  domicilio = row[13]
	  add = v.addresses.new(:place => "Principal", :domicilio => domicilio, :codigopostal => 0,
	  					:estado => ".", :municipio => ".", :colonia => ".")
	  (add.valid? and !add.domicilio.eql?(".")) ? v.addresses << add : false
	end
	puts "Todos los voluntarios cargados"
	###############################################
	######################################################
	CSV.foreach(Rails.root.join("db","catalogos","volyssss.txt"), :col_sep =>"\t") do |row|
	  v = Volunteer.find_by_oldid(row[0])
	  if v.nil?
	  	puts "Error en voluntario #{row[0]}"
	  	break
      end
      if v.status == 1
      	inicio = row[1].eql?(".") ? Date.today : row[1].to_date
      	fin = row[2].eql?(".") ? Date.today : row[2].to_date

      	ss = v.socialservices.new(:horas => row[7], :escuela => row[3], :carrera => row[3],
        					 :matricula => row[4], :semestre => row[5], :inicio => inicio, :fin => fin)
        if ss.valid?
          ss.save
        end
	  end 
	end
	puts "Todos los registros de Servicio Social cargados"
	######################################################
	######################################################
	CSV.foreach(Rails.root.join("db","catalogos","volysshor.txt"), :col_sep =>"\t") do |row|
	  v = Volunteer.find_by_oldid(row[0])
	  if v.nil?
	  	puts "Error en voluntario #{row[0]}"
	  	break
      end
      if v.status == 1
      	day = 1
        7.times do |t|
      	  ini = "#{Date.today} #{row[day]}".to_time
      	  fin = "#{Date.today} #{row[day+1]}".to_time

      	  d = v.dailyschedules.new(:day => t+1, :begin => ini, :end => fin)
		  if d. valid? and d.tiempo_num > 0
      	    d.save
		  end
		  day += 2
		end
	  end 
	end
	puts "Todos los registros de Horarios cargados"
	######################################################		
	#################################################
	CSV.foreach(Rails.root.join("db","catalogos","volysssub.txt"), :col_sep =>"\t") do |row|
	  v = Volunteer.find_by_oldid(row[8])
	  if v.nil?
	  	puts "Error en voluntario #{row[8]}"
	  	break
      end
	  donador = row[0] == 'SI' ? true : false
	  eventos = row[1] == 'SI' ? true : false
	  hospitales = row[2] == 'SI' ? true : false
	  suenosdeseos = row[3] == 'SI' ? true : false
	  fondos = row[4] == 'SI' ? true : false
	  administrativas = row[5] == 'SI' ? true : false
	  autoayuda = row[6] == 'SI' ? true : false
	  sobrevivientes = row[7] == 'SI' ? true : false
	  fugarte = row[9] == 'SI' ? true : false
	  v.create_subprogram(:donador => donador, :eventos => eventos, :hospitales => hospitales,
	  					  :suenosdeseos => suenosdeseos, :fondos => fondos, :administrativas => administrativas, 
	  					  :autoayuda => autoayuda, :sobrevivientes => sobrevivientes, :fugarte => fugarte)		
	end
	puts "Todos los Subprogramas cargados"
	#################################################
  end
end