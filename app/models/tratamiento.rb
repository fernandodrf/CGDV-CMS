# == Schema Information
#
# Table name: tratamientos
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tratamiento < ActiveRecord::Base 
  belongs_to :patient
  
  validates :patient_id, :presence => true
  validates :tipo, :presence => true, :length => { :maximum => 50}
  
  TIPOS = ['Qt', 'Qx', 'Rt', 'Qt + Rt', 'Qt + Rt + Qx', 'Qt + Qx', 'Qx + Rt', 'Inm + Qx', 'Inm', 'Paliativo', 'Otros']
end
