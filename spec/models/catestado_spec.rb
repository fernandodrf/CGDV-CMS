# == Schema Information
#
# Table name: catestados
#
#  id         :integer          not null, primary key
#  estado     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Catestado, type: :model do
  it "has a valid factory" do
      estado = FactoryBot.build(:catestado)
      estado.valid?
      # puts "estado: #{estado.inspect}"
      expect(estado).to be_valid
  end

  let (:estado) { FactoryBot.create(:catestado) }
  describe "Validations" do
    # Basic validations
    # FIXME
    xit { is_expected.to validate_presence_of :estado }
    # FIXME
    xit { expect(estado).to_not allow_value(nil).for(:estado) }
    it { expect(estado).to allow_value('Cualquier string @#$% 34').for(:estado) }
  end
  pending "Add controller to add/edit/remove model elements"
end
