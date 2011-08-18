require 'test_helper'

class SocialserviceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: socialservices
#
#  id           :integer         not null, primary key
#  horas        :string(255)
#  escuela      :string(255)
#  carrera      :string(255)
#  matricula    :string(255)
#  semestre     :string(255)
#  inicio       :date
#  fin          :date
#  volunteer_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

