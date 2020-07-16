# == Schema Information
#
# Table name: activity_reports
#
#  id           :integer          not null, primary key
#  reporte      :text
#  semana       :integer
#  volunteer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ActivityReport < ApplicationRecord
  belongs_to :volunteer
  
  before_create :get_week
  before_create :set_week

  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :volunteer_id, :presence => true
  #Para contar que tenga minimo 1 y maximo 750 palabras
  validates :reporte, :presence => true, :length => {
    :minimum   => 1,
    :maximum   => 750,
    :tokenizer => lambda { |str| str.scan(/\w+/) }
  }
  
  private

	def get_week
	  week = Time.now.strftime("%W").to_i
	  wday = Time.now.wday
	  week = wday <= 3 ?  week - 1 : week
	  	
	  registro = ActivityReport.find(:all, :conditions => {:volunteer_id => self.volunteer_id, :semana => week})
	  if !registro.empty?
	   errors[:semana] = ": Ya existe un registro de esta Semana"
	   return false
  	  end
	end
	
	def set_week
	  week = Time.now.strftime("%W").to_i
	  wday = Time.now.wday
	  if wday <= 3
	    self.semana = week - 1
	  else
	    self.semana = week
	  end
	end
end
