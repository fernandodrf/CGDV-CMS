# == Schema Information
# Schema version: 20110628211104
#
# Table name: tratamientos
#
#  id         :integer         not null, primary key
#  tipo       :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tratamiento < ActiveRecord::Base
  attr_accessible :tipo
  
  belongs_to :patient
  
  validates :tipo, :presence => true, :length => { :maximum => 50}
  
  TIPOS = ['Qt', 'Qx', 'Rt', 'Qt + Rt', 'Qt + Rt + Qx', 'Qt + Qx', 'Qx + Rt', 'Inm + Qx', 'Inm', 'Paliativo', 'Otros']
  
end
