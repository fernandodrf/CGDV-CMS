require 'rails_helper'

RSpec.describe CatalogoDerechohabiente, type: :model do
  it "has a valid factory" do
      derechohabiente = FactoryBot.build(:catalogo_derechohabiente)
      derechohabiente.valid?
      # puts "derechohabiente: #{derechohabiente.inspect}"
      expect(derechohabiente).to be_valid
  end

  let (:derechohabiente) { FactoryBot.create(:catalogo_derechohabiente) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :seguro }
    it { expect(derechohabiente).to_not allow_value(nil).for(:seguro) }
    it { expect(derechohabiente).to allow_value('Cualquier string @#$% 34').for(:seguro) }
  end
  pending "Add controller to add/edit/remove model elements"
end
