require 'test_helper'

class ElementTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: elements
#
#  id          :integer         not null, primary key
#  codigo      :string(255)
#  cantidad    :integer
#  cuota       :decimal(22, 2)
#  descripcion :string(255)
#  note_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

