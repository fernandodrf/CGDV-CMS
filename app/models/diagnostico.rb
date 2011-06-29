# == Schema Information
# Schema version: 20110629011817
#
# Table name: diagnosticos
#
#  id          :integer         not null, primary key
#  diagnostico :string(255)
#  patient_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Diagnostico < ActiveRecord::Base
  
  attr_accessible :diagnostico
  
  validates :diagnostico, :presence => true
  
  belongs_to :patient
  
end
