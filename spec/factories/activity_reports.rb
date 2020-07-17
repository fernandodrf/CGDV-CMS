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

FactoryBot.define do
  factory :activity_report do
    volunteer_id { 1 }
    reporte { Faker::Lorem.paragraph(sentence_count: 2) }
    semana { 1 }
  end
end
