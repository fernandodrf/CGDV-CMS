#update several Models to Polymorphic

#Comments
namespace :db do
	
  desc "Update Comments to Polymorphic"
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
  end
end
