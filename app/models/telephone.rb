class Telephone < ActiveRecord::Base 
  belongs_to :telephoneable, :polymorphic => true

  validates :place, :presence => true, :length => { :maximum => 50 }
  validates :number, :presence => true, :length => { :maximum => 50 }
  validates :telephoneable_id, :presence => true
  validates :telephoneable_type, :presence => true
end