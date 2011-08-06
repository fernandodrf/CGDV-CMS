class Diagnostico < ActiveRecord::Base
  
  attr_accessible :diagnostico
  
  belongs_to :patient
  
  validates :diagnostico, :presence => true
  validates :patient_id, :presence => true
  
end

# == Schema Information
#
# Table name: diagnosticos
#
#  id          :integer         not null, primary key
#  patient_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  diagnostico :integer
#

