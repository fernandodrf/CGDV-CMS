namespace :db do
	
  desc "Update Status of Patients"
  task :patientstatus => :environment do
=begin	
    Patient.all.each do |p|    	
      #Update id's
      p.status = 1
      if !p.save
        puts "Error en Patient id: #{p.id}"
      end      	
    end
=end
  end
end