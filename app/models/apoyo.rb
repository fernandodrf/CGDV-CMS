class Apoyo < ActiveRecord::Base
  belongs_to :patient
  
  validates :patient_id, :presence => true
  validates :tipo, :presence => true, :length => { :maximum => 50}

  TIPOS = ['Medicamentos', 'Equipo', 'Psicologico', 'Transplante de Medula Osea', 'Sobreviviente', 'Cuidados Paliativos', 'Transporte', 'Alimentacion', 'Donadores de Sangre', 'Otros']    
end
