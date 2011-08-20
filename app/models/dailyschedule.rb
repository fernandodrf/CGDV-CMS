class Dailyschedule < ActiveRecord::Base
  belongs_to :volunteer
  
  attr_accessible :day, :begin, :end
  
  validates :begin, :presence => true
  validates :end, :presence => true
  validates :day, :presence => true
  validates :volunteer_id, :presence => true
  
  DAYS = [['Lunes',1],['Martes',2],['Miercoles',3],['Jueves',4],['Viernes',5],['Sabado',6],['Domingo',7]]
  
  def tiempo
  	tiempo = (Time.mktime(0)+(self.end - self.begin)).strftime("%H hr. %M min.")
  end
  
end

# == Schema Information
#
# Table name: dailyschedules
#
#  id           :integer         not null, primary key
#  day          :string(255)
#  begin        :time
#  end          :time
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

