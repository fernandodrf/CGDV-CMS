class Timereport < ActiveRecord::Base
  belongs_to :volunteer
  
  attr_accessible :day, :begin, :end, :evento, :volunteer_id

  validates :day, :presence => true  
  validates :begin, :presence => true
  validates :end, :presence => true
  validates :volunteer_id, :presence => true
  
  DAYS = [['Lunes',1],['Martes',2],['Miercoles',3],['Jueves',4],['Viernes',5],['Sabado',6],['Domingo',7]]

    def tiempo
      total = self.end - self.begin
      hrs = (total/3600).to_i
  	  mins = (total/60 - hrs * 60).to_i
  	  return "#{hrs} hrs, #{mins} mins"
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

