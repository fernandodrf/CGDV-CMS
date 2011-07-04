class FamilyMember < ActiveRecord::Base

  attr_accessible :parentesco, :nombre, :edad, :derechohabiente, :comentarios

  belongs_to :patient

  validates :patient_id, :presence => true
  validates :parentesco, :presence => true, :length => { :maximum => 50}
  validates :nombre, :presence => true, :length => { :maximum => 250}
  validates :edad, :presence => true, :length => { :maximum => 10}, :numericality => true
  validates :derechohabiente, :presence => true, :length => { :maximum => 50}
  #validates :comentarios, :presence => true, :length => { :maximum => 250}
  
  FAM = ['Padre o Madre', 'Herman@', 'Hij@', 'Conyuge', 'Ti@', 'Sobrin@', 'Otr@']
  DH = ['Ninguno', 'IMSS', 'ISSSTE', 'IMSS + ISSSTE']
  
end

# == Schema Information
#
# Table name: family_members
#
#  id              :integer         not null, primary key
#  parentesco      :string(255)
#  nombre          :string(255)
#  edad            :integer
#  derechohabiente :string(255)
#  comentarios     :string(255)
#  patient_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

