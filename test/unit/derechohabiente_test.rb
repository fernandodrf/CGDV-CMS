require 'test_helper'

class DerechohabienteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: derechohabientes
#
#  id         :integer         not null, primary key
#  seguro     :string(255)
#  afiliacion :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

