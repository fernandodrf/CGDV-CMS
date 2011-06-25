# == Schema Information
# Schema version: 20110625161711
#
# Table name: patientphones
#
#  id         :integer         not null, primary key
#  place      :string(255)
#  number     :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Patientphone < ActiveRecord::Base
  attr_accessible :place, :number
  
  belongs_to :patient

  validates :place, :presence => true, :length => { :maximum => 50 }
  validates :number, :presence => true, :length => { :maximum => 50 }
  validates :patient_id, :presence => true
  
end
