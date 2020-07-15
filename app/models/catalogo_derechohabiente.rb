# == Schema Information
#
# Table name: catalogo_derechohabientes
#
#  id         :integer          not null, primary key
#  seguro     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatalogoDerechohabiente < ActiveRecord::Base
	
  validates :seguro, :presence => true, :length => { :maximum => 50 }
  
end
