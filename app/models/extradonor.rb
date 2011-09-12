class Extradonor < ActiveRecord::Base
  attr_accessible :pautoriza, :pcontacto
  belongs_to :donor
end


# == Schema Information
#
# Table name: extradonors
#
#  id         :integer         not null, primary key
#  pautoriza  :string(255)
#  pcontacto  :string(255)
#  donor_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

