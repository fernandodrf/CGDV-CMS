class Derechohabiente < ActiveRecord::Base
  belongs_to :patient

  validates :seguro, :presence => true, :length => { :maximum => 50 }
  validates :afiliacion, :presence => true, :length => { :maximum => 50 }
  validates :patient_id, :presence => true
  
end
