# == Schema Information
#
# Table name: apoyos
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Apoyo, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }
  
  it "has a valid factory" do
      apoyo = FactoryBot.build(:apoyo, patient_id: patient.id)
      apoyo.valid?
      # puts "Apoyo: #{apoyo.inspect}"
      expect(apoyo).to be_valid
  end
  
  let (:apoyo) { FactoryBot.create(:apoyo, patient_id: patient.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :tipo }
    it { is_expected.to validate_presence_of :patient_id }
    # Inclusion/acceptance of values
    # pending "add some inclusion/acceptance validations"
    it { is_expected.to validate_length_of(:tipo).is_at_most(50) }
    # Format validations
    it "should allow valid values in Apoyo::TIPOS" do
      Apoyo::TIPOS.each do |v|
        should allow_value(v).for(:tipo)
      end
    end
    it { expect(apoyo).to_not allow_value(nil).for(:tipo) }
    it { expect(apoyo).to allow_value(1).for(:patient_id) }
    it { expect(apoyo).to_not allow_value(nil).for(:patient_id) }
  end

  describe "Associations" do
    it { should belong_to(:patient) }
  end
end
