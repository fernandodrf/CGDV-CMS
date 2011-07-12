require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  folio      :integer
#  adeudo     :decimal(22, 2)
#  acuenta    :decimal(22, 2)
#  restan     :decimal(22, 2)
#  subtotal   :decimal(22, 2)
#  total      :decimal(22, 2)
#  fecha      :date
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

