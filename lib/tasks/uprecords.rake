#update several Models to Polymorphic

#Comments
namespace :db do
	
  desc "Update Models to Polymorphic"
  task :uprecords => :environment do
=begin  	
    Comment.all.each do |comment|    	
      #Update id's
      comment.commentable_id = comment.patient_id
      comment.commentable_type = Patient.to_s
      if !comment.save
        puts "Error en Comment id: #{comment.id}"
      end      	
    end
    puts "Cometarios Actualizados "
   
    Telephone.all.each do |telephone|	
      #Update id's
      telephone.telephoneable_id = telephone.patient_id
      telephone.telephoneable_type = Patient.to_s
      if !telephone.save
        puts "Error en Telephone id: #{comment.id}"
      end	
    end
    puts "Telefonos Actualizados"    
=end
    Address.all.each do |address|	
      #Update id's
      address.addresseable_id = address.patient_id
      address.addresseable_type = Patient.to_s
      if !address.save
        puts "Error en Address id: #{comment.id}"
      end	
    end
    puts "Direcciones Actualizados"
  end
end
