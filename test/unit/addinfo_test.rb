require 'test_helper'

class AddinfoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: addinfos
#
#  id                  :integer         not null, primary key
#  tipo                :integer
#  info                :string(255)
#  addinformation_id   :integer
#  addinformation_type :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

