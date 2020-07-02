require 'rails_helper'

RSpec.describe Email, type: :model do
  # Lazy loading of upper model
  let (:patient) { FactoryBot.create(:patient) }

  describe "for Patients" do
    it "has a valid factory" do
      email = FactoryBot.build(:email, emailable_type: 'Patient', emailable_id: patient.id)
      email.valid?
      # puts "Email: #{email.inspect}"
      expect(email).to be_valid
    end
  end

  let (:email) { FactoryBot.create(:email, emailable_type: 'Patient', emailable_id: patient.id) }
  describe "ActiveModel Validations" do
    # Basic validations and inclusion/acceptance of values
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :emailable_id }
    it { is_expected.to validate_presence_of :emailable_type }
    # Format validations
    it { expect(email).to allow_value('Patient').for(:emailable_type) }
    it { expect(email).to allow_value(1).for(:emailable_id) }
    it { expect(email).to allow_value('juan@casa.com.mx').for(:email) }
    it { expect(email).to allow_value('juan@casa.mx').for(:email) }
    it { expect(email).to_not allow_value('juan@').for(:email) }
    it { expect(email).to_not allow_value('casa.com.mx').for(:email) }
    it { expect(email).to_not allow_value(nil).for(:emailable_id) }
    it { expect(email).to_not allow_value(nil).for(:emailable_type) }    
  end

  describe "ActiveRecord Associations" do
    it { should belong_to(:emailable) }
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
