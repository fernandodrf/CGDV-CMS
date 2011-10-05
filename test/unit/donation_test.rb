require 'test_helper'

class DonationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: donations
#
#  id          :integer         not null, primary key
#  folio       :integer
#  donor_id    :integer
#  frecepcion  :date
#  tipo        :integer
#  monto       :string(255)
#  transaccion :string(255)
#  finalidad   :string(255)
#  motivo      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

