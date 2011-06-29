require 'test_helper'

class PatientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: patients
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  created_at :datetime
#  updated_at :datetime
#  sex        :string(255)
#  birthdate  :date
#  blod       :string(255)
#

