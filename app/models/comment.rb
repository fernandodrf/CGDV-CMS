# == Schema Information
# Schema version: 20110628215344
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  comment    :text
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  attr_accessible :comment
  
  belongs_to :patient
  
  validates :comment, :presence => true
  
end
