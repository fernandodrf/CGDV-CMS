class Addinfo < ActiveRecord::Base 
  belongs_to :addinformation, :polymorphic => true

  validates :addinformation_id, :presence => true
  validates :addinformation_type, :presence => true  
  validates :tipo, :presence => true, :numericality => true
  validates :info, :presence => true
  
  ADDINFO = [['MSN Messenger',1],['Pagina Web',2],['Facebook',3],['Twitter',4],['Skype',5],['Nombre de Asistente', 6],['Otro',7],['R.F.C.',8]]
end