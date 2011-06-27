# == Schema Information
# Schema version: 20110627183639
#
# Table name: addresses
#
#  id           :integer         not null, primary key
#  place        :string(255)
#  codigopostal :integer
#  estado       :string(255)
#  municipio    :string(255)
#  colonia      :string(255)
#  domicilio    :string(255)
#  patient_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Address < ActiveRecord::Base
  attr_accessible :place, :codigopostal, :estado, :municipio, :colonia, :domicilio
  
  belongs_to :patient

  validates :patient_id, :presence => true
  validates :place, :presence => true, :length => { :maximum => 50 }
  validates :codigopostal, :presence => true, :length => { :maximum => 5 }
  validates :estado, :presence => true, :length => { :maximum => 50 }
  validates :municipio, :presence => true, :length => { :maximum => 50 }
  validates :colonia, :presence => true, :length => { :maximum => 50 }
  validates :domicilio, :presence => true
  
end
