# == Schema Information
#
# Table name: diagnosticos
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  diagnostico         :integer
#  diagnosticable_id   :integer
#  diagnosticable_type :string(255)
#

require 'rails_helper'

RSpec.describe Diagnostico, type: :model do
# Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  describe "for Patients" do
    it "has a valid factory" do
      diag = FactoryBot.build(:diagnostico, diagnosticable_type: 'Patient', diagnosticable_id: patient.id)
      diag.valid?
      # puts "Diagnostico: #{diag.inspect}"
      expect(diag).to be_valid
    end
  end

  let (:diagnostico) { FactoryBot.create(:diagnostico, diagnosticable_type: 'Patient', diagnosticable_id: patient.id) }
  describe "ActiveModel Validations" do
    # Basic validations 
    it { is_expected.to validate_presence_of :diagnostico }
    it { is_expected.to validate_presence_of :diagnosticable_id }
    it { is_expected.to validate_presence_of :diagnosticable_type }
    # Inclusion/acceptance of values
    # Format validations
    it { expect(diagnostico).to allow_value('Patient').for(:diagnosticable_type) }
    it { expect(diagnostico).to allow_value(1).for(:diagnosticable_id) }
    it { expect(diagnostico).to allow_value(100).for(:diagnostico) }
    it { expect(diagnostico).to_not allow_value(nil).for(:diagnosticable_id) }
    it { expect(diagnostico).to_not allow_value(nil).for(:diagnosticable_type) }    
  end

  describe "ActiveRecord Associations" do
    it { should belong_to(:diagnosticable) }
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
