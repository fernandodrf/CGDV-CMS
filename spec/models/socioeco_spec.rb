# == Schema Information
#
# Table name: socioecos
#
#  id               :integer          not null, primary key
#  ingresos         :integer
#  gastos           :integer
#  televisiones     :integer
#  vehiculos        :integer
#  nivel            :string(255)
#  serviciosurbanos :string(255)
#  televisionpaga   :string(255)
#  sgmm             :string(255)
#  patient_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Socioeco, type: :model do
 # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  it "has a valid factory" do
      var = FactoryBot.build(:socioeco, patient_id: patient.id)
      var.valid?
      # puts "Family member: #{var.inspect}"
      expect(var).to be_valid
  end

  let (:socioeco) { FactoryBot.create(:socioeco, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :patient_id }
    it { is_expected.to validate_presence_of :ingresos }
    it { is_expected.to validate_presence_of :gastos }
    it { is_expected.to validate_presence_of :televisiones }
    it { is_expected.to validate_presence_of :vehiculos }
    it { is_expected.to validate_presence_of :nivel }
    it { is_expected.to validate_presence_of :serviciosurbanos }
    it { is_expected.to validate_presence_of :televisionpaga }
    it { is_expected.to validate_presence_of :sgmm }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:nivel).is_at_most(50) }
    it { is_expected.to validate_length_of(:serviciosurbanos).is_at_most(50) }
    it { is_expected.to validate_length_of(:televisionpaga).is_at_most(50) }
    it { is_expected.to validate_length_of(:sgmm).is_at_most(50) }
    it { is_expected.to validate_numericality_of :ingresos }
    it { is_expected.to validate_numericality_of :gastos }
    it { is_expected.to validate_numericality_of :televisiones }
    it { is_expected.to validate_numericality_of :vehiculos }
    # Format validations
    it { expect(socioeco).to_not allow_value(nil).for(:patient_id) }
    it { expect(socioeco).to allow_value(1).for(:patient_id) }
    it { expect(socioeco).to allow_value(1234567890).for(:ingresos) }
    it { expect(socioeco).to_not allow_value(12345678901).for(:ingresos) }
    it { expect(socioeco).to allow_value(1234567890).for(:gastos) }
    it { expect(socioeco).to_not allow_value(12345678901).for(:gastos) }
    it { expect(socioeco).to allow_value(1234567890).for(:televisiones) }
    it { expect(socioeco).to_not allow_value(12345678901).for(:televisiones) }
    it { expect(socioeco).to allow_value(1234567890).for(:vehiculos) }
    it { expect(socioeco).to_not allow_value(12345678901).for(:vehiculos) }

    it { expect(socioeco).to allow_value('Super mega hiper comentario').for(:sgmm) }
  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
