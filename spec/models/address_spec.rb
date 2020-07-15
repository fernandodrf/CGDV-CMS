# == Schema Information
#
# Table name: addresses
#
#  id                :integer          not null, primary key
#  place             :string(255)
#  estado            :string(255)
#  municipio         :string(255)
#  colonia           :string(255)
#  domicilio         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  addresseable_id   :integer
#  addresseable_type :string(255)
#  country           :integer          default(1)
#  codigopostal      :string(255)
#

require 'rails_helper'

RSpec.describe Address, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      address = FactoryBot.build(:address, addresseable_id: patient.id)
      address.valid?
      # puts "Apoyo: #{address.inspect}"
      expect(address).to be_valid
  end
  
  let (:address) { FactoryBot.create(:address, addresseable_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :addresseable_id }
    it { is_expected.to validate_presence_of :addresseable_type }
    it { is_expected.to validate_presence_of :estado }
    it { is_expected.to validate_presence_of :domicilio }
    it { is_expected.to validate_presence_of :codigopostal }
    pending "Renombrar columnas"
    it { expect(address).to allow_value('Patient').for(:addresseable_type) }
    it { expect(address).to_not allow_value(nil).for(:addresseable_id) }
    it { expect(address).to_not allow_value(nil).for(:addresseable_type) }
    it { expect(address).to allow_value('Perecuaro').for(:estado) }
    it { expect(address).to allow_value('San Eleuterio Mendez No. 46').for(:domicilio) }
    it { expect(address).to allow_value('12456378954').for(:codigopostal) }
  end

  describe "Associations" do
    it { should belong_to(:addresseable) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
