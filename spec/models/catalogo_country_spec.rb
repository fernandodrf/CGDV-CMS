require 'rails_helper'

RSpec.describe CatalogoCountry, type: :model do
  it "has a valid factory" do
      country = FactoryBot.build(:catalogo_country)
      country.valid?
      # puts "country: #{country.inspect}"
      expect(country).to be_valid
  end

  let (:country) { FactoryBot.create(:catalogo_country) }
  describe "Validations" do
    # Basic validations
    # FIXME
    xit { is_expected.to validate_presence_of :country }
    # FIXME
    xit { expect(country).to_not allow_value(nil).for(:country) }
    it { expect(country).to allow_value('Cualquier string').for(:country) }
  end
  pending "Add controller to add/edit/remove model elements"
end
