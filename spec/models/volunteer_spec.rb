# == Schema Information
#
# Table name: volunteers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  sex        :string(255)
#  blood      :string(255)
#  status     :integer          default(1)
#  birth      :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string(255)
#

require 'rails_helper'

RSpec.describe Volunteer, type: :model do
	it "has a valid factory" do
    expect(FactoryBot.build(:volunteer)).to be_valid
    # puts "Volunteer: #{volunteer.inspect}"
  end

let (:volunteer) { FactoryBot.create(:volunteer) }
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
    it { is_expected.to validate_presence_of :blood }
    it { is_expected.to validate_length_of(:blood).is_at_most(5) }
    it { is_expected.to validate_inclusion_of(:blood).in_array(Volunteer::BLOODTYPES) }
    # birthdate
    it { is_expected.to validate_presence_of :birth }
    # status
    it { is_expected.to validate_presence_of :status }
    xit { is_expected.to validate_numericality_of :status }
    # FIXME  
    xit { is_expected.to validate_inclusion_of(:status).in_range(1..2) }

    # Format validations
    it { expect(volunteer).to allow_value('Juan Perez').for(:name) }
    it { expect(volunteer).to allow_value(rand(1..10000)).for(:cgdvcode) }
    it { expect(volunteer).to_not allow_value(nil).for(:cgdvcode) }
    it { expect(volunteer).to_not allow_value(1234567890012345678900).for(:cgdvcode) }
    it { expect(volunteer).to allow_value('yes').for(:sex) }
    it { expect(volunteer).to_not allow_value('muchisimo').for(:sex) }
    it { expect(volunteer).to allow_value('NS').for(:blood) }
    xit { expect(volunteer).to_not allow_value('O').for(:blood) }
    it { expect(volunteer).to allow_value(Faker::Date.birthday).for(:birth) }
    it { expect(volunteer).to_not allow_value('01-13-1900').for(:birth) }
    it { expect(volunteer).to allow_value(2).for(:status) }
    # FIXME
    xit { expect(volunteer).to_not allow_value(0).for(:status) }
    it { expect(volunteer).to_not allow_value(nil).for(:status) }
  end

  describe "ActiveRecord Associations" do
    # Associations
    it { expect(volunteer).to have_many(:telephones).dependent(:destroy) }
    it { expect(volunteer).to have_many(:addresses).dependent(:destroy) }
    it { expect(volunteer).to have_many(:addinfos).dependent(:destroy) }
    it { expect(volunteer).to have_many(:emails).dependent(:destroy) }
    it { expect(volunteer).to have_many(:comments).dependent(:destroy) }
    it { expect(volunteer).to have_many(:diagnosticos).dependent(:destroy) }
    it { expect(volunteer).to have_many(:timereports).dependent(:destroy) }
    it { expect(volunteer).to have_many(:vol_times).dependent(:destroy) }
    it { expect(volunteer).to have_many(:dailyschedules).dependent(:destroy) }
    it { expect(volunteer).to have_many(:extravolunteers).dependent(:destroy) }
    it { expect(volunteer).to have_many(:socialservices).dependent(:destroy) }
    it { expect(volunteer).to have_many(:activity_reports).dependent(:destroy) }
    it { expect(volunteer).to have_one(:subprogram).dependent(:destroy) }
    it { expect(volunteer).to have_one(:user) }
  end  
  
  it "is succesfully saved when name, cgdvcode, sex, blood, birthdate and status are present" do
    volunteer = FactoryBot.build(:volunteer)
    volunteer.save
    puts "Volunteer: #{volunteer.inspect}"
    expect(volunteer).to be_valid
  end



end
