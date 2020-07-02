require 'rails_helper'

RSpec.describe House, type: :model do

# Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  it "has a valid factory" do
      house = FactoryBot.build(:house, patient_id: patient.id)
      house.valid?
      # puts "Family member: #{house.inspect}"
      expect(house).to be_valid
  end

  let (:house) { FactoryBot.create(:house, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :patient_id }
    it { is_expected.to validate_presence_of :habitaciones }
    it { is_expected.to validate_presence_of :tipo }
    it { is_expected.to validate_presence_of :habitantes }
    it { is_expected.to validate_presence_of :familiares }
    it { is_expected.to validate_presence_of :menores }
    it { is_expected.to validate_presence_of :economicaactivas }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:tipo).is_at_most(50) }
    #it { is_expected.to validate_length_of(:habitaciones).is_at_most(10) }
    #it { is_expected.to validate_length_of(:habitantes).is_at_most(10) }
    #it { is_expected.to validate_length_of(:familiares).is_at_most(10) }
    #it { is_expected.to validate_length_of(:menores).is_at_most(10) }
    #it { is_expected.to validate_length_of(:economicaactivas).is_at_most(10) }
    it { is_expected.to validate_numericality_of :habitaciones }
    it { is_expected.to validate_numericality_of :habitantes }
    it { is_expected.to validate_numericality_of :familiares }
    it { is_expected.to validate_numericality_of :menores }
    it { is_expected.to validate_numericality_of :economicaactivas }
    # Format validations
    pending "Ampliar variables TIPOS"
    it "should allow valid values in House::TIPOS" do
      House::TIPOS.each do |v|
        should allow_value(v).for(:tipo)
      end
    end

    it { expect(house).to_not allow_value(nil).for(:patient_id) }
    it { expect(house).to allow_value(1).for(:patient_id) }
    it { expect(house).to_not allow_value(nil).for(:habitaciones) }
    it { expect(house).to_not allow_value(nil).for(:habitantes) }
    it { expect(house).to_not allow_value(nil).for(:familiares) }
    it { expect(house).to_not allow_value(nil).for(:menores) }
    it { expect(house).to_not allow_value(nil).for(:economicaactivas) }
    it { expect(house).to allow_value(1234567890).for(:habitaciones) }
    it { expect(house).to_not allow_value(12345678901).for(:habitaciones) }
    it { expect(house).to allow_value(1234567890).for(:habitantes) }
    it { expect(house).to_not allow_value(12345678901).for(:habitantes) }
    it { expect(house).to allow_value(1234567890).for(:familiares) }
    it { expect(house).to_not allow_value(12345678901).for(:familiares) }
    it { expect(house).to allow_value(1234567890).for(:menores) }
    it { expect(house).to_not allow_value(12345678901).for(:menores) }
    it { expect(house).to allow_value(1234567890).for(:economicaactivas) }
    it { expect(house).to_not allow_value(12345678901).for(:economicaactivas) }

  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end


end
