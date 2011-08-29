require 'test_helper'

class VolunteerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



# == Schema Information
#
# Table name: volunteers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  sex        :string(255)
#  blood      :string(255)
#  status     :integer         default(1)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#  oldid      :string(255)
#

