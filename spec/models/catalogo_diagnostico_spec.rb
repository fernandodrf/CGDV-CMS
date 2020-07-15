# == Schema Information
#
# Table name: catalogo_diagnosticos
#
#  id          :integer          not null, primary key
#  diagnostico :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe CatalogoDiagnostico, type: :model do
  it "has a valid factory" do
      diagnostico = FactoryBot.build(:catalogo_diagnostico)
      diagnostico.valid?
      # puts "diagnostico: #{diagnostico.inspect}"
      expect(diagnostico).to be_valid
  end

  let (:diagnostico) { FactoryBot.create(:catalogo_diagnostico) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :diagnostico }
    it { expect(diagnostico).to_not allow_value(nil).for(:diagnostico) }
    it { expect(diagnostico).to allow_value('Cualquier string @#$% 34').for(:diagnostico) }
  end
  pending "Add controller to add/edit/remove model elements"
end
