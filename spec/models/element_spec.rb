require 'rails_helper'

RSpec.describe Element, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient, :active) }
  let (:note) { FactoryBot.create(:note, patient_id: patient.id) }

  it "has a valid factory" do
    element = FactoryBot.build(:element, note_id: note.id)
    # puts "Element: #{element.inspect}"
    element.valid?
    expect(element).to be_valid
  end

  let (:element) { FactoryBot.create(:element, note_id: note.id) }
  describe "Validations" do
    # Basic validations
    # FIXME
    xit { is_expected.to validate_presence_of :note_id }
    it { is_expected.to validate_presence_of :codigo }
    it { is_expected.to validate_presence_of :descripcion }
    it { is_expected.to validate_presence_of :cantidad }
    it { is_expected.to validate_presence_of :cuota }
    # Inclusion/acceptance of values
    it { is_expected.to validate_numericality_of :cantidad }
    it { is_expected.to validate_numericality_of :cuota }
    # Format validations
    it { expect(element).to allow_value(rand(1..100)).for(:cantidad) }
    it { expect(element).to allow_value(rand(1.0..100.00)).for(:cuota) }
    it { expect(element).to_not allow_value(nil).for(:cantidad) }
    it { expect(element).to_not allow_value(nil).for(:cuota) }
  end

  describe "Associations" do
    it { should belong_to(:note) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
