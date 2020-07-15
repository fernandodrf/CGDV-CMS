# == Schema Information
#
# Table name: diagnosticos
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  diagnostico         :integer
#  diagnosticable_id   :integer
#  diagnosticable_type :string(255)
#

class Diagnostico < ActiveRecord::Base  
  belongs_to :diagnosticable, :polymorphic => true
  
  validates :diagnostico, :presence => true
  validates :diagnosticable_id, :presence => true
  validates :diagnosticable_type, :presence => true  
end
