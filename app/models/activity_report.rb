class ActivityReport < ActiveRecord::Base
  attr_accessible :reporte, :volunteer_id
end

# == Schema Information
#
# Table name: activity_reports
#
#  id           :integer         not null, primary key
#  reporte      :text
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

