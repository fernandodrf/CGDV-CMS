class ChangeVolunteersToSubprogramsColumns < ActiveRecord::Migration
  def self.up 	
  	rename_column :extravolunteers, :sobreviviente, :sobreviviente_old
  	rename_column :extravolunteers, :licencia, :licencia_old
  	rename_column :extravolunteers, :exposferias, :exposferias_old
  	
  	add_column :subprograms, :sobreviviente, :boolean
  	add_column :subprograms, :licencia, :boolean
  	add_column :subprograms, :exposferias, :boolean
  	
  	Volunteer.reset_column_information
    Volunteer.find_each do |v| 
      if !v.extravolunteers.first.nil?
      	if v.subprogram.nil?
      	  v.create_subprogram(:sobreviviente => v.extravolunteers.first.sobreviviente_old, 
      	  					 :exposferias => v.extravolunteers.first.exposferias_old,
      	  					 :licencia => v.extravolunteers.first.licencia_old)
  		else
          v.subprogram.update_attribute(:sobreviviente, v.extravolunteers.first.sobreviviente_old)
          v.subprogram.update_attribute(:exposferias, v.extravolunteers.first.exposferias_old)
          v.subprogram.update_attribute(:licencia, v.extravolunteers.first.licencia_old)
    	end
      end
     end
      
    remove_column :extravolunteers, :sobreviviente_old
	remove_column :extravolunteers, :licencia_old
  	remove_column :extravolunteers, :exposferias_old  	
  end

  def self.down
  	rename_column :subprograms, :sobreviviente, :sobreviviente_old
  	rename_column :subprograms, :licencia, :licencia_old
  	rename_column :subprograms, :exposferias, :exposferias_old
  	
  	add_column :extravolunteers, :sobreviviente, :boolean
  	add_column :extravolunteers, :licencia, :boolean
  	add_column :extravolunteers, :exposferias, :boolean
  	
  	Volunteer.reset_column_information
    Volunteer.find_each do |v| 
      if !v.subprogram.nil?
      	if v.extravolunteers.first.nil?
      	  v.extravolunteers.create(:sobreviviente => v.subprogram.sobreviviente_old, 
      	  						   :exposferias => v.subprogram.exposferias_old,
      	  						   :licencia => v.subprogram.licencia_old)
  		else
          v.extravolunteers.first.update_attribute(:sobreviviente, v.subprogram.sobreviviente_old)
          v.extravolunteers.first.update_attribute(:exposferias, v.subprogram.exposferias_old)
          v.extravolunteers.first.update_attribute(:licencia, v.subprogram.licencia_old)
    	end
      end
     end
      
    remove_column :subprograms, :sobreviviente_old
	remove_column :subprograms, :licencia_old
  	remove_column :subprograms, :exposferias_old  
  end
end
