class CatalogoDerechohabiente < ActiveRecord::Base
	
  validates :seguro, :presence => true, :length => { :maximum => 50 }
  
end
