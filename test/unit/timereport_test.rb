require 'test_helper'

class TimereportTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: timereports
#
#  id           :integer         not null, primary key
#  day          :date
#  begin        :time
#  end          :time
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

