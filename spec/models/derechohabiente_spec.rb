# == Schema Information
#
# Table name: derechohabientes
#
#  id         :integer          not null, primary key
#  seguro     :string(255)
#  afiliacion :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Derechohabiente, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      dh = FactoryBot.build(:derechohabiente, patient_id: patient.id)
      dh.valid?
      # puts "Derechohabiente: #{dh.inspect}"
      expect(dh).to be_valid
  end
  
  let (:derechohabiente) { FactoryBot.create(:derechohabiente, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :seguro }
    it { is_expected.to validate_presence_of :afiliacion }
    it { is_expected.to validate_presence_of :patient_id }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:seguro).is_at_most(50) }
    it { is_expected.to validate_length_of(:afiliacion).is_at_most(50) }
    # Format validations
    pending "crear variable en modelo con TIPOS de derechohabientes"
    # it "should allow valid values in Derechohabiente::TIPOS" do
      # Derechohabiente::TIPOS.each do |v|
        # should allow_value(v).for(:tipo)
      # end
    # end
    it { expect(derechohabiente).to_not allow_value(nil).for(:seguro) }
    it { expect(derechohabiente).to_not allow_value(nil).for(:afiliacion) }
    it { expect(derechohabiente).to allow_value('Peje Seguro').for(:seguro) }
    it { expect(derechohabiente).to allow_value('Peje Clave: 12-34_567/21/7').for(:seguro) }
    it { expect(derechohabiente).to allow_value(1).for(:patient_id) }
    it { expect(derechohabiente).to_not allow_value(nil).for(:patient_id) }
  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end
end
