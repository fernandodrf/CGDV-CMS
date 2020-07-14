class House < ActiveRecord::Base
  belongs_to :patient

  validates :patient_id, :presence => true
  validates :habitaciones, :presence => true,
  			:length => { :maximum => 10},
			:numericality => true
  validates :tipo, :presence => true, :length => { :maximum => 50}
  validates :habitantes, :presence => true,
  			:length => { :maximum => 10},
			:numericality => true
  validates :familiares, :presence => true,
  			:length => { :maximum => 10},
			:numericality => true
  validates :menores, :presence => true,
  			:length => { :maximum => 10},
			:numericality => true
  validates :economicaactivas, :presence => true,
  			:length => { :maximum => 10},
			:numericality => true

  TIPOS = ['Albergue', 'Alquiler', 'Prestada', 'Rentada', 'Propia', 'Institucion Medica', 'Sin Vivienda']
  
end