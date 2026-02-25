# == Schema Information
#
# Table name: vol_times
#
#  id           :integer          not null, primary key
#  evento       :string(255)
#  horas        :integer
#  volunteer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class VolTime < ApplicationRecord
  ransack_allow_all!
  belongs_to :volunteer
  
  validates :horas, :presence => true, :numericality => true
  validates :volunteer_id, :presence => true
end
