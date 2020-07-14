class Dailyschedule < ActiveRecord::Base
  belongs_to :volunteer
  
  validates :begin, :presence => true
  validates :end, :presence => true
  validates :day, :presence => true
  validates :volunteer_id, :presence => true
  
  DAYS = [['Lunes',1],['Martes',2],['Miercoles',3],['Jueves',4],['Viernes',5],['Sabado',6],['Domingo',7]]

  def tiempo
    total = self.end - self.begin
    hrs = (total/3600).to_i
    mins = (total/60 - hrs * 60).to_i
    return "#{hrs} hrs, #{mins} mins"
  end
    
  def tiempo_num
    total = self.end - self.begin
    hrs = (total/3600).to_i
    mins = (total/60 - hrs * 60).to_i
    return hrs+mins
  end    
end