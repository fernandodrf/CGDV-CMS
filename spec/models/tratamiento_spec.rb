require 'rails_helper'

RSpec.describe Tratamiento, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      trat = FactoryBot.build(:tratamiento, patient_id: patient.id)
      trat.valid?
      # puts "Tratamiento: #{trat.inspect}"
      expect(trat).to be_valid
  end
  
  let (:tratamiento) { FactoryBot.create(:tratamiento, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :tipo }
    it { is_expected.to validate_presence_of :patient_id }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:tipo).is_at_most(50) }
    # Format validations
    it "should allow valid values in Tratamiento::TIPOS" do
      Tratamiento::TIPOS.each do |v|
        should allow_value(v).for(:tipo)
      end
    end
    it { expect(tratamiento).to_not allow_value(nil).for(:tipo) }
    it { expect(tratamiento).to allow_value(1).for(:patient_id) }
    it { expect(tratamiento).to_not allow_value(nil).for(:patient_id) }
  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end
end
