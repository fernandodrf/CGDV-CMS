require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end



# == Schema Information
#
# Table name: addresses
#
#  id                :integer         not null, primary key
#  place             :string(255)
#  codigopostal      :integer
#  estado            :string(255)
#  municipio         :string(255)
#  colonia           :string(255)
#  domicilio         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  addresseable_id   :integer
#  addresseable_type :string(255)
#

