class Element < ActiveRecord::Base
  belongs_to :note
  
  validates :codigo, :presence => true,:length => { :maximum => 250}
  validates :descripcion, :presence => true, :length => { :maximum => 250}
  validates :cantidad, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :cuota, :presence => true, :length => { :maximum => 20}, :numericality => true
end