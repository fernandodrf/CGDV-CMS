require 'test_helper'

class TelephoneTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: telephones
#
#  id                 :integer         not null, primary key
#  place              :string(255)
#  number             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  telephoneable_id   :integer
#  telephoneable_type :string(255)
#

