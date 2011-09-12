require 'test_helper'

class ExtradonorTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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

