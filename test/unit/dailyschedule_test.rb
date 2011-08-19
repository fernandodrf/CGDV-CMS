require 'test_helper'

class DailyscheduleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: dailyschedules
#
#  id           :integer         not null, primary key
#  day          :string(255)
#  begin        :time
#  end          :time
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

