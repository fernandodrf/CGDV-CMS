# == Schema Information
#
# Table name: addinfos
#
#  id                  :integer          not null, primary key
#  tipo                :integer
#  info                :string(255)
#  addinformation_id   :integer
#  addinformation_type :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'rails_helper'

RSpec.describe Addinfo, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      addinfo = FactoryBot.build(:addinfo, addinformation_id: patient.id)
      addinfo.valid?
      # puts "Apoyo: #{addinfo.inspect}"
      expect(addinfo).to be_valid
  end
  
  let (:addinfo) { FactoryBot.create(:addinfo, addinformation_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :tipo }
    it { is_expected.to validate_presence_of :info }
    it { is_expected.to validate_presence_of :addinformation_id }
    it { is_expected.to validate_presence_of :addinformation_type }
    it { is_expected.to validate_numericality_of(:tipo) }
    pending "Validar rango de :tipo"
    # it { is_expected.to validate_inclusion_of(:tipo).in_range(1..8) }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    # Format validations
    # it "should allow valid values in Addinfo::ADDINFO" do
    pending "Validar uso de Addinfo::ADDINFO en :tipo"
      # Addinfo::ADDINFO.each do |v|
        # should allow_value(v).for(:tipo)
      # end
    # end
    it { expect(addinfo).to allow_value('Patient').for(:addinformation_type) }
    it { expect(addinfo).to_not allow_value(nil).for(:tipo) }
    it { expect(addinfo).to_not allow_value(nil).for(:info) }
    it { expect(addinfo).to_not allow_value(nil).for(:addinformation_id) }
    it { expect(addinfo).to_not allow_value(nil).for(:addinformation_type) }
  end

  describe "Associations" do
    it { should belong_to(:addinformation) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
