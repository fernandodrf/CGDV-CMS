require 'test_helper'

class DonorTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: donors
#
#  id         :integer         not null, primary key
#  cgdvcode   :integer
#  persona    :integer
#  name       :string(255)
#  rfc        :string(255)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#

