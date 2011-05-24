# == Schema Information
# Schema version: 20110524164246
#
# Table name: patients
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Patient < ActiveRecord::Base
  attr_accessible :name, :cgdvcode
  
  validates :name, :presence => true, 
            :length => { :maximum => 250}
  validates :cgdvcode, :presence => true,
  			:length => { :maximum => 20},
			:numericality => true, 
            :uniqueness => true
end
