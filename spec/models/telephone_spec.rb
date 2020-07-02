require 'rails_helper'

RSpec.describe Telephone, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  describe "for Patients" do
    it "has a valid factory" do
      tel = FactoryBot.build(:tel_casa, telephoneable_type: 'Patient', telephoneable_id: patient.id)
      tel.valid?
      # puts "Tel: #{tel.inspect}"
      expect(tel).to be_valid
    end
  end

  let (:telephone) { FactoryBot.create(:tel_casa, telephoneable_type: 'Patient', telephoneable_id: patient.id) }
  describe "ActiveModel Validations" do
    # Basic validations 
    it { is_expected.to validate_presence_of :place }
    it { is_expected.to validate_presence_of :number }
    it { is_expected.to validate_presence_of :telephoneable_id }
    it { is_expected.to validate_presence_of :telephoneable_type }
    # Inclusion/acceptance of values
    it { is_expected.to validate_length_of(:place).is_at_most(50) }
    it { is_expected.to validate_length_of(:number).is_at_most(50) }
    # Format validations
    it { expect(telephone).to allow_value('casa').for(:place) }
    it { expect(telephone).to allow_value('55217899').for(:number) }
    it { expect(telephone).to allow_value('01/485/55217899').for(:number) }
    it { expect(telephone).to_not allow_value(nil).for(:place) }
    it { expect(telephone).to_not allow_value(nil).for(:number) }    
  end

  describe "ActiveRecord Associations" do
    it { should belong_to(:telephoneable) }
  end
end
