require 'test_helper'

class FamilyMemberTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: family_members
#
#  id              :integer         not null, primary key
#  parentesco      :string(255)
#  nombre          :string(255)
#  edad            :integer
#  derechohabiente :string(255)
#  comentarios     :string(255)
#  patient_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#

