require 'test_helper'

class ActivityReportTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ActivityReport.new.valid?
  end
end


# == Schema Information
#
# Table name: activity_reports
#
#  id           :integer         not null, primary key
#  reporte      :text
#  semana       :integer
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

