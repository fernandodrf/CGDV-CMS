class Diagnostico < ActiveRecord::Base  
  attr_accessible :diagnostico
  
  belongs_to :diagnosticable, :polymorphic => true
  
  validates :diagnostico, :presence => true
  validates :diagnosticable_id, :presence => true
  validates :diagnosticable_type, :presence => true  
  
end


# == Schema Information
#
# Table name: diagnosticos
#
#  id                  :integer         not null, primary key
#  patient_id          :integer
#  created_at          :datetime
#  updated_at          :datetime
#  diagnostico         :integer
#  diagnosticable_id   :integer
#  diagnosticable_type :string(255)
#

