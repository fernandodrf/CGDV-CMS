# == Schema Information
#
# Table name: activity_reports
#
#  id           :integer          not null, primary key
#  reporte      :text
#  semana       :integer
#  volunteer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe ActivityReport, type: :model do
# Lazy loading of upper model
  let (:volunteer) { FactoryBot.create(:volunteer) }
  
  it "has a valid factory" do
      activity_report = FactoryBot.build(:activity_report, volunteer_id: volunteer.id)
      activity_report.valid?
      # puts "activity_report: #{activity_report.inspect}"
      expect(activity_report).to be_valid
  end
  
  let (:activity_report) { FactoryBot.create(:activity_report, volunteer_id: volunteer.id) }
  describe "Validations" do
    # Basic validations
    it { is_expected.to validate_presence_of :volunteer_id }
    it { is_expected.to validate_length_of(:reporte).is_at_least(1) }
    it { is_expected.to_not allow_value(nil).for(:volunteer_id) }
    it { is_expected.to_not allow_value('').for(:volunteer_id) }
    it { is_expected.to allow_value(Faker::Lorem.paragraph(sentence_count: 10)).for(:reporte) }
    pending "contar maximo 750 palabras"
    pending "validar con set_week"
    pending "validar con get_week"
    pending "validar que ya hay reporte esa semana"
  end

  describe "Associations" do
    it { is_expected.to belong_to(:volunteer) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
