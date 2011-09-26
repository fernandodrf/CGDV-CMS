class ChangeHorasToVolTimes < ActiveRecord::Migration
  def self.up
  	Volunteer.reset_column_information
    Volunteer.find_each do |v| 
      if !v.socialservices.first.nil?
      	#Cambiar las horas de servicio Social
	    v.vol_times.create(:horas => v.socialservices.first.horas.to_i,
	    				   :evento => "Horas de Servicio Social Iniciales",
	    				   :created_at => v.socialservices.first.created_at)
      end
    end
    remove_column :socialservices, :horas 
  end

  def self.down
  	add_column :socialservices, :horas, :string
  	#regresar horas a social services
  	Volunteer.reset_column_information
    Volunteer.find_each do |v| 
  	  if !v.vol_times.empty? and !v.socialservices.first.nil?
  	  	vt = v.vol_times("Horas de Servicio Social Iniciales")
  	    horas = vt.horas
  	    v.socialservices.first.update_attribute(:horas => horas)
  	    vt.destroy
  	  end
  	end
  end
end
