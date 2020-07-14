class VolTime < ActiveRecord::Base
  belongs_to :volunteer
  
  validates :horas, :presence => true, :numericality => true
  validates :volunteer_id, :presence => true
end