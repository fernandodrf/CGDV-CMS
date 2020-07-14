class Diagnostico < ActiveRecord::Base  
  belongs_to :diagnosticable, :polymorphic => true
  
  validates :diagnostico, :presence => true
  validates :diagnosticable_id, :presence => true
  validates :diagnosticable_type, :presence => true  
end