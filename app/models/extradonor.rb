# == Schema Information
#
# Table name: extradonors
#
#  id         :integer          not null, primary key
#  pautoriza  :string(255)
#  pcontacto  :string(255)
#  donor_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Extradonor < ActiveRecord::Base
  belongs_to :donor
end
