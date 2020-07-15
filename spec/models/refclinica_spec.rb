# == Schema Information
#
# Table name: refclinicas
#
#  id         :integer          not null, primary key
#  hospital   :string(255)
#  medico     :string(255)
#  referencia :date
#  aceptado   :string(255)
#  ayudas     :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Refclinica, type: :model do
# Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  it "has a valid factory" do
      rfc = FactoryBot.build(:refclinica, patient_id: patient.id)
      rfc.valid?
      # puts "Family member: #{rfc.inspect}"
      expect(rfc).to be_valid
  end

  let (:refclinica) { FactoryBot.create(:refclinica, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :patient_id }
    it { is_expected.to validate_presence_of :hospital }
    it { is_expected.to validate_presence_of :medico }
    it { is_expected.to validate_presence_of :referencia }
    it { is_expected.to validate_presence_of :aceptado }
    it { is_expected.to validate_presence_of :ayudas }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:hospital).is_at_most(50) }
    it { is_expected.to validate_length_of(:medico).is_at_most(250) }
    it { is_expected.to validate_length_of(:aceptado).is_at_most(250) }
    it { is_expected.to validate_length_of(:ayudas).is_at_most(250) }
    # Format validations
    it { expect(refclinica).to allow_value('Hospital Mi Alegria del Sagrado Corazon de Jesus').for(:hospital) }
    it { expect(refclinica).to allow_value('Sebastian GomÉz Pérez Prado Tongez Mongo').for(:medico) }
  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
