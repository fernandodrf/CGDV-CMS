require 'rails_helper'

RSpec.describe Patient, :type => :model do

it "has a valid factory" do
    expect(FactoryBot.build(:patient)).to be_valid
    # puts "Patient: #{patient.inspect}"
  end

  let (:patient) { FactoryBot.create(:patient) }
  describe "ActiveModel Validations" do
    # Basic validations and inclusion/acceptance of values
    # name
    it { is_expected.to validate_presence_of :name }
    # cgdvcode
    it { is_expected.to validate_presence_of :cgdvcode }
    it { is_expected.to validate_numericality_of :cgdvcode }
    # validate_length_of does not works
    # it { is_expected.to validate_length_of(:cgdvcode).is_at_most(20) }
    it { is_expected.to validate_uniqueness_of :cgdvcode }
    # sex
    it { is_expected.to validate_presence_of :sex }
    it { is_expected.to validate_length_of(:sex).is_at_most(5) }
    # Blood Type
    it { is_expected.to validate_presence_of :blod }
    it { is_expected.to validate_length_of(:blod).is_at_most(5) }
    it { is_expected.to validate_inclusion_of(:blod).in_array(Patient::BLOODTYPES) }
    pending "change blod to blood"
    # birthdate
    it { is_expected.to validate_presence_of :birthdate }
    # status
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_numericality_of :status }
    it { is_expected.to validate_inclusion_of(:status).in_range(1..6) }

    # Format validations
    it { expect(patient).to allow_value('Juan Perez').for(:name) }
    it { expect(patient).to allow_value(rand(1..10000)).for(:cgdvcode) }
    it { expect(patient).to_not allow_value(nil).for(:cgdvcode) }
    it { expect(patient).to_not allow_value(1234567890012345678900).for(:cgdvcode) }
    it { expect(patient).to allow_value('yes').for(:sex) }
    it { expect(patient).to_not allow_value('muchisimo').for(:sex) }
    it { expect(patient).to allow_value('NS').for(:blod) }
    it { expect(patient).to_not allow_value('O').for(:blod) }
    it { expect(patient).to allow_value(Faker::Date.birthday).for(:birthdate) }
    it { expect(patient).to_not allow_value('01-13-1900').for(:birthdate) }
    it { expect(patient).to allow_value(2).for(:status) }
    it { expect(patient).to_not allow_value(0).for(:status) }
    it { expect(patient).to_not allow_value(nil).for(:status) }
  end

  describe "ActiveRecord Associations" do
    # Associations
    it { expect(patient).to have_many(:notes).dependent(:destroy) }
    it { expect(patient).to have_many(:telephones).dependent(:destroy) }
    it { expect(patient).to have_many(:diagnosticos).dependent(:destroy) }
    it { expect(patient).to have_many(:emails).dependent(:destroy) }
    it { expect(patient).to have_many(:addinfos).dependent(:destroy) }
    it { expect(patient).to have_many(:addresses).dependent(:destroy) }
    it { expect(patient).to have_many(:tratamientos).dependent(:destroy) }
    it { expect(patient).to have_many(:apoyos).dependent(:destroy) }
    it { expect(patient).to have_many(:family_members).dependent(:destroy) }
    it { expect(patient).to have_many(:comments).dependent(:destroy) }
    it { expect(patient).to have_many(:attachments).dependent(:destroy) }
    it { expect(patient).to have_one(:house).dependent(:destroy) }
    it { expect(patient).to have_one(:refclinica).dependent(:destroy) }
    it { expect(patient).to have_one(:socioeco).dependent(:destroy) }
  end  
  
  it "is succesfully saved when name, cgdvcode, sex, blood, birthdate and status are present" do
    patient = FactoryBot.build(:patient)
    patient.save
    #puts "Patient: #{patient.inspect}"
    expect(patient).to be_valid
  end

end

