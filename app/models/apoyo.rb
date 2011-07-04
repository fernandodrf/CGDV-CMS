# == Schema Information
# Schema version: 20110628202801
#
# Table name: apoyos
#
#  id         :integer         not null, primary key
#  tipo       :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Apoyo < ActiveRecord::Base
  attr_accessible :tipo
  
  belongs_to :patient
  
  validates :patient_id, :presence => true
  validates :tipo, :presence => true, :length => { :maximum => 50}

  TIPOS = ['Medicamentos', 'Equipo', 'Psicologico', 'Transplante de Medula Osea', 'Sobreviviente', 'Cuidados Paliativos', 'Transporte', 'Alimentacion', 'Donadores de Sangre', 'Otros']    
end
