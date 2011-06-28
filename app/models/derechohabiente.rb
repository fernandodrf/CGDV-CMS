# == Schema Information
# Schema version: 20110627234414
#
# Table name: derechohabientes
#
#  id         :integer         not null, primary key
#  seguro     :string(255)
#  afiliacion :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Derechohabiente.all.collect {|d| [d.seguro] } 

class Derechohabiente < ActiveRecord::Base
  attr_accessible :seguro, :afiliacion
  
  belongs_to :patient

  validates :seguro, :presence => true, :length => { :maximum => 50 }
  validates :afiliacion, :presence => true, :length => { :maximum => 50 }
  validates :patient_id, :presence => true
  
  TIPOS = ['IMSS', 'ISSSTE', 'Sedena', 'Beneficencia', 'Sector Salud Estatal', 'Semar', 'Privado', 'SSGDF', 'SSA', 'Otros', 'ISSEMYM', 'Seguro Popular']
  
end
