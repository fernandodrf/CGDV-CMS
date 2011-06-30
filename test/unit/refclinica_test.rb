require 'test_helper'

class RefclinicaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: refclinicas
#
#  id         :integer         not null, primary key
#  hospital   :string(255)
#  medico     :string(255)
#  referencia :date
#  aceptado   :string(255)
#  ayudas     :string(255)
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

