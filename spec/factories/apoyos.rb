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

FactoryBot.define do
  factory :apoyo do
    tipo { "Un Apoyo" }
    patient_id { 1 }
  end
end
