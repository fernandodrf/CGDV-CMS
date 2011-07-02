require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: houses
#
#  id               :integer         not null, primary key
#  habitaciones     :integer
#  tipo             :string(255)
#  habitantes       :integer
#  familiares       :integer
#  menores          :integer
#  economicaactivas :integer
#  patient_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#

