require 'test_helper'

class DiagnosticoTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end




# == Schema Information
#
# Table name: diagnosticos
#
#  id                  :integer         not null, primary key
#  created_at          :datetime
#  updated_at          :datetime
#  diagnostico         :integer
#  diagnosticable_id   :integer
#  diagnosticable_type :string(255)
#

