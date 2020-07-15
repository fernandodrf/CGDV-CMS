# == Schema Information
#
# Table name: extravolunteers
#
#  id           :integer          not null, primary key
#  profesion    :string(255)
#  volunteer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Extravolunteer < ActiveRecord::Base
  belongs_to :volunteer
end
