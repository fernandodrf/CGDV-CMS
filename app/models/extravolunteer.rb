class Extravolunteer < ActiveRecord::Base
  attr_accessible :profesion
  belongs_to :volunteer
end



# == Schema Information
#
# Table name: extravolunteers
#
#  id           :integer         not null, primary key
#  profesion    :string(255)
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

