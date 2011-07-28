#update several Models to Polymorphic

#Comments
namespace :db do
  desc "Update Comments to Polymorphic"
  task :uprecords => :environment do
    Comment.all.each do |comment|
      #Update id's
      comment.commentable_id = comment.patient_id
      comment.commentable_type = Patient.to_s
      if !comment.save
        puts "Error en Comment id: #{comment.id}"
      end	
    end
  end
end
