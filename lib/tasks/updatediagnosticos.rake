namespace :db do
	
  desc "Update Diagnosticos on Patients"
  task :updatediagnosticos => :environment do
 
    Patient.all.each do |p|    	
      #Update id's on Diagnosticos
      if !p.diagnosticos.empty?
      	p.diagnosticos.all.each do |d|
      	  #puts "#{d.diagnostico}"
      	  
      	 if d.diagnostico == "Otros"
      	  	d.diagnostico = 188
  	     end
=begin      	  
          s = CatalogoDiagnostico.search(:diagnostico_contains => d.diagnostico)
          diag = s.relation[0]
          if diag.nil?
            puts "Diag Nil: #{d.diagnostico} Pat ID: #{p.id}"
          	break
          end
          #puts "#{diag.id}"
          d.diagnostico = diag.id
          #puts "Patient ID: #{p.id} Diagnostico ID: #{diag.id}"
=end
          
          if !d.save
          	puts "Error on Patient ID: #{p.id} Diagnostico ID: #{diag.id}"
          	break
      	  end
        end
      end         	
    end   
  end
end