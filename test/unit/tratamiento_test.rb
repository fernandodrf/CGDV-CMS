require 'test_helper'

class TratamientoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: tratamientos
#
#  id         :integer         not null, primary key
#  tipo       :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

