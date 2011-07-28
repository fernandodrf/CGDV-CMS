class Address < ActiveRecord::Base
  attr_accessible :place, :codigopostal, :estado, :municipio, :colonia, :domicilio
  
  belongs_to :addresseable, :polymorphic => true

  validates :addresseable_id, :presence => true
  validates :addresseable_type, :presence => true
  validates :place, :presence => true, :length => { :maximum => 50 }
  validates :codigopostal, :presence => true, :numericality => true,  :length => { :maximum => 5 }
  validates :estado, :presence => true, :length => { :maximum => 50 }
  validates :municipio, :presence => true, :length => { :maximum => 50 }
  validates :colonia, :presence => true, :length => { :maximum => 50 }
  validates :domicilio, :presence => true

  EDOS = ['Aguascalientes','Baja California','Baja California Sur','Campeche','Chiapas','Chihuahua','Coahuila','Colima','Distrito Federal','Durango','Estado de Mexico','Guanajuato','Guerrero','Hidalgo','Jalisco','Michoacan','Morelos','Nayarit','Nuevo Leon','Oaxaca','Puebla','Queretaro','Quintana Roo','San Luis Potosi','Sinaloa','Sonora','Tabasco','Tamaulipas','Tlaxcala','Veracruz','Yucatan','Zacatecas']

end

# == Schema Information
#
# Table name: addresses
#
#  id                :integer         not null, primary key
#  place             :string(255)
#  codigopostal      :integer
#  estado            :string(255)
#  municipio         :string(255)
#  colonia           :string(255)
#  domicilio         :string(255)
#  patient_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  addresseable_id   :integer
#  addresseable_type :string(255)
#

