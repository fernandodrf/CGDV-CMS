class Volunteer < ActiveRecord::Base
  attr_accessible :name, :cgdvcode, :blood, :sex, :status, :birth, :extravolunteers_attributes, :socialservices_attributes

  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :diagnosticos, :as => :diagnosticable, :dependent => :destroy
  
  has_many :timereports, :dependent => :destroy
  has_many :vol_times, :dependent => :destroy
  has_many :dailyschedules, :dependent => :destroy	
  has_many :extravolunteers, :dependent => :destroy
  has_many :socialservices, :dependent => :destroy
  
  has_one :subprogram, :dependent => :destroy  
  has_one :user
  
  accepts_nested_attributes_for :extravolunteers, :allow_destroy => true
  accepts_nested_attributes_for :socialservices, :allow_destroy => true
  
  validates :name, :presence => true
  validates :status, :presence => true
  validates :cgdvcode, :presence => true, 
  			:length => { :maximum => 20},
			:numericality => true, 
            :uniqueness => true
  validates :sex, :presence => true, :length => { :maximum => 5}
  validates :blood, :presence => true, :length => { :maximum => 5}
  validates :birth, :presence => true

  BLOODTYPES = ['NS', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
  STATUS = [['Servicio Social',1],['Voluntario',2]] 

  #Tiempo Acumuado
  def ta
  	total = tiempototal
  	hrs = (total/3600).to_i
  	mins = (total/60 - hrs * 60).to_i
  	return "#{hrs} hrs, #{mins} mins"
  end  

  def dt
  	total = tiempototal2
  	hrs = (total/3600).to_i
  	mins = (total/60 - hrs * 60).to_i
  	return "#{hrs} hrs, #{mins} mins"
  end 

  def tr
  	total = tiempototal3
  	return "#{tiempototal3} horas"
  end
  
  def tiempo_final
    restantes = tiempototal3
    acumuladas = tiempoacumulado
    
    if restantes > acumuladas[0]
    
      hrs = restantes - acumuladas[0]
      mins = 0
    
      if acumuladas[1] > 0
        hrs -= 1
        mins = 60 - acumuladas[1]
	  end
	else
	  hrs = acumuladas[0] - restantes
	  mins = acumuladas[1]
	end
	
	return "#{hrs} hrs, #{mins} mins"
  end 

  private
  
	def tiempototal
	  trs = self.timereports
	  total = 0
	  
	  trs.each do |tr|
	    total += tr.end - tr.begin
	  end
	  return total
	end
	
	
	def tiempoacumulado
	  trs = self.timereports
	  total = 0
	  
	  trs.each do |tr|
	    total += tr.end - tr.begin
	  end
	    hrs = (total/3600).to_i
  		mins = (total/60 - hrs * 60).to_i
	  return [hrs,mins]
	end
	
	def tiempototal2
	  trs = self.dailyschedules	
	  total = 0
	  
	  trs.each do |tr|
	    total += tr.end - tr.begin
	  end
	  return total
	end

	def tiempototal3
	  trs = self.vol_times	
	  total = 0
	  
	  trs.each do |tr|
	    total += tr.horas
	  end
	  return total
	end
  
end


# == Schema Information
#
# Table name: volunteers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  sex        :string(255)
#  blood      :string(255)
#  status     :integer         default(1)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#

