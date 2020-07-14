class Address < ActiveRecord::Base
  belongs_to :addresseable, :polymorphic => true

  validates :addresseable_id, :presence => true
  validates :addresseable_type, :presence => true
  validates :codigopostal, :presence => true#, :numericality => true,  :length => { :maximum => 5 }
  validates :estado, :presence => true#, :length => { :maximum => 50 }
  validates :domicilio, :presence => true
  
  #validates :place, :presence => true#, :length => { :maximum => 50 }
  #validates :municipio, :presence => true, :length => { :maximum => 50 }
  #validates :colonia, :presence => true, :length => { :maximum => 50 }
end