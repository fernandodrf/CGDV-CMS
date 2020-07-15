# == Schema Information
#
# Table name: family_members
#
#  id              :integer          not null, primary key
#  parentesco      :string(255)
#  nombre          :string(255)
#  edad            :integer
#  derechohabiente :string(255)
#  comentarios     :string(255)
#  patient_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe FamilyMember, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  it "has a valid factory" do
      fm = FactoryBot.build(:family_member, patient_id: patient.id)
      fm.valid?
      # puts "Family member: #{fm.inspect}"
      expect(fm).to be_valid
  end

  let (:family_member) { FactoryBot.create(:family_member, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :patient_id }
    it { is_expected.to validate_presence_of :parentesco }
    it { is_expected.to validate_presence_of :nombre }
    it { is_expected.to validate_presence_of :edad }
    it { is_expected.to validate_presence_of :derechohabiente }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:parentesco).is_at_most(50) }
    it { is_expected.to validate_length_of(:derechohabiente).is_at_most(50) }
    # FIXME
    xit { is_expected.to validate_length_of(:nombre).is_at_most(255) }
    # it { is_expected.to validate_length_of(:edad).is_at_most(4) }
    it { is_expected.to validate_numericality_of :edad }
    # Format validations
    pending "Ampliar variables FAM/DH"
    it "should allow valid values in FamilyMember::FAM" do
      FamilyMember::FAM.each do |v|
        should allow_value(v).for(:parentesco)
      end
    end
    it "should allow valid values in FamilyMember::DH" do
      FamilyMember::FAM.each do |v|
        should allow_value(v).for(:derechohabiente)
      end
    end

    it { expect(family_member).to_not allow_value(nil).for(:patient_id) }
    it { expect(family_member).to allow_value(1).for(:patient_id) }
    it { expect(family_member).to_not allow_value(nil).for(:parentesco) }
    it { expect(family_member).to_not allow_value(nil).for(:nombre) }
    it { expect(family_member).to_not allow_value(nil).for(:edad) }
    # FIXME
    xit { expect(family_member).to_not allow_value(12345).for(:edad) }
    it { expect(family_member).to_not allow_value(nil).for(:derechohabiente) }
    it { expect(family_member).to allow_value('Super mega hiper comentario').for(:comentarios) }
  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
