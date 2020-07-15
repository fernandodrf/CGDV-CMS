# == Schema Information
#
# Table name: tratamientos
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :tratamiento do
    tipo { "Qt + Rx" }
    patient_id { 1 }
  end
end
