class VolTime < ActiveRecord::Base
  attr_accessible :evento, :horas, :volunteer_id
  
  belongs_to :volunteer
  
  validates :horas, :presence => true, :numericality => true
  validates :volunteer_id, :presence => true
end

# == Schema Information
#
# Table name: vol_times
#
#  id           :integer         not null, primary key
#  evento       :string(255)
#  horas        :integer
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

