class Refclinica < ActiveRecord::Base
  belongs_to :patient

  validates :patient_id, :presence => true
  validates :hospital, :presence => true, :length => { :maximum => 50}
  validates :medico, :presence => true, :length => { :maximum => 250}
  validates :referencia, :presence => true
  validates :aceptado, :presence => true, :length => { :maximum => 250}
  validates :ayudas, :presence => true, :length => { :maximum => 250}
end