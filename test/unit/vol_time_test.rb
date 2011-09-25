require 'test_helper'

class VolTimeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: vol_times
#
#  id           :integer         not null, primary key
#  evento       :string(255)
#  horas        :integer
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

