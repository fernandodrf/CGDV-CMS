require 'rails_helper'

RSpec.describe Note, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient, :active) }
  let (:patient_inactive) { FactoryBot.create(:patient, :inactive) }


  it "has a valid factory" do
    note = FactoryBot.build(:note, patient_id: patient.id)
    # puts "Note: #{note.inspect}"
    note.valid?
    expect(note).to be_valid
  end

  let (:note) { FactoryBot.create(:note, patient_id: patient.id) }
  let (:note_invalid) { FactoryBot.create(:note, patient_id: patient_inactive.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :patient_id }
    it { is_expected.to validate_presence_of :folio }
    it { is_expected.to validate_presence_of :fecha }
    it { is_expected.to validate_presence_of :adeudo }
    it { is_expected.to validate_presence_of :acuenta }
    it { is_expected.to validate_presence_of :restan }
    it { is_expected.to validate_presence_of :subtotal }
    it { is_expected.to validate_presence_of :total }
    # Inclusion/acceptance of values
    it { is_expected.to validate_numericality_of :adeudo }
    it { is_expected.to validate_numericality_of :acuenta }
    it { is_expected.to validate_numericality_of :restan }
    it { is_expected.to validate_numericality_of :subtotal }
    it { is_expected.to validate_numericality_of :total }
    # Format validations
    it { expect(note).to allow_value(rand(1.0..100.00)).for(:adeudo) }
    it { expect(note).to allow_value(rand(1.0..100.00)).for(:acuenta) }
    it { expect(note).to allow_value(rand(1.0..100.00)).for(:restan) }
    it { expect(note).to allow_value(rand(1.0..100.00)).for(:subtotal) }
    it { expect(note).to allow_value(rand(1.0..100.00)).for(:total) }

  end

  describe "Associations" do
    it { should belong_to(:patient) }
    it { expect(note).to have_many(:elements).dependent(:destroy) }
    it { expect(note).to have_many(:attachments).dependent(:destroy) }

    it "check_status method has to be nil for active patients (1)" do
      # puts "Patient Status: #{note.send(:check_status).inspect}"
      expect(note.send(:check_status)).to be_nil
    end

    # FIXME
    xit "check_status method has to be false for not active patients (!=1)" do
      # puts "Patient Status: #{note_invalid.send(:check_status).inspect}"
      expect(note_invalid.send(:check_status)).to be false
    end
  end

  pending "add validations in model for adeudo, acuenta, restan, subtotal and total "
end
