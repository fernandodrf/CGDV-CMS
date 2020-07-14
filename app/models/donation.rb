class Donation < ActiveRecord::Base
  belongs_to :donor
  
  validates :donor_id, :presence => true
  validates :folio, :presence => true,:length => { :maximum => 20},
  			:numericality => true, :uniqueness => true
  validates :frecepcion, :presence => true
  validates :tipo, :presence => true
  validates :motivo, :presence => true
  
  TIPO = [['Efectivo',1],['Especie',2],['Transferencia',3],['Tarjeta',4],['Deposito',5],['Paypal',6],['Banxol',7],['Otro',0]]
  MOTIVO = [['Gestion',1],['Espontaneo',2],['En Memoria',3],['Campania',4],['Dedicado',5],['Otro',0]]
end