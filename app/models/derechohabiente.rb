# == Schema Information
#
# Table name: derechohabientes
#
#  id         :integer          not null, primary key
#  seguro     :string(255)
#  afiliacion :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Derechohabiente < ActiveRecord::Base
  belongs_to :patient

  validates :seguro, :presence => true, :length => { :maximum => 50 }
  validates :afiliacion, :presence => true, :length => { :maximum => 50 }
  validates :patient_id, :presence => true
  
end
