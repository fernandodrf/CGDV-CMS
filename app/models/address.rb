# == Schema Information
#
# Table name: addresses
#
#  id                :integer          not null, primary key
#  place             :string(255)
#  estado            :string(255)
#  municipio         :string(255)
#  colonia           :string(255)
#  domicilio         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  addresseable_id   :integer
#  addresseable_type :string(255)
#  country           :integer          default(1)
#  codigopostal      :string(255)
#

class Address < ApplicationRecord
  belongs_to :addresseable, :polymorphic => true

  validates :addresseable_id, :presence => true
  validates :addresseable_type, :presence => true
  validates :codigopostal, :presence => true#, :numericality => true,  :length => { :maximum => 5 }
  validates :estado, :presence => true#, :length => { :maximum => 50 }
  validates :domicilio, :presence => true
  
  #validates :place, :presence => true#, :length => { :maximum => 50 }
  #validates :municipio, :presence => true, :length => { :maximum => 50 }
  #validates :colonia, :presence => true, :length => { :maximum => 50 }
end
