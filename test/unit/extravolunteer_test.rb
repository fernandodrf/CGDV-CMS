require 'test_helper'

class ExtravolunteerTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: extravolunteers
#
#  id            :integer         not null, primary key
#  profesion     :string(255)
#  sobreviviente :boolean
#  licencia      :boolean
#  exposferias   :boolean
#  volunteer_id  :integer
#  created_at    :datetime
#  updated_at    :datetime
#

