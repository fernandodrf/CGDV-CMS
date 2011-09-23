class Timereport < ActiveRecord::Base
  belongs_to :volunteer
  
  attr_accessible :day, :begin, :end, :evento, :volunteer_id

  validates :day, :presence => true  
  validates :begin, :presence => true
  validates :end, :presence => true
  validates :volunteer_id, :presence => true
  
  DAYS = [['Lunes',1],['Martes',2],['Miercoles',3],['Jueves',4],['Viernes',5],['Sabado',6],['Domingo',7]]
  EVENTO = ['Eventos Especiales', 'Apoyo Intrahospitalario', 'Suenos y Deseos', 'Captacion de Fondos', 'Apoyo en Labores Administrativas', 'Grupos de Autoayuda','Sobrevivientes', 'Fugarte', 'Dia de Reyes', 'Dia del Nin@', 'Corriendo por la Vida', 'Donador de sangre y o plaquetas', 'Curso de Capacitacion Basico', 'Curso de Capacitacion A', 'Curso de Capacitacion B', 'Curso de Capacitacion C', 'Curso de Capacitacion D', 'Curso de Capacitacion Tematico', 'Otr@s']

    def tiempo
      total = self.end - self.begin
      hrs = (total/3600).to_i
  	  mins = (total/60 - hrs * 60).to_i
  	  return "#{hrs} hrs, #{mins} mins"
    end
    
    def tiempo_num
      total = self.end - self.begin
      hrs = (total/3600).to_i
  	  mins = (total/60 - hrs * 60)/100.to_i
  	  return [hrs,mins]
    end 
  
end



# == Schema Information
#
# Table name: timereports
#
#  id           :integer         not null, primary key
#  day          :date
#  begin        :time
#  end          :time
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#  evento       :string(255)
#

