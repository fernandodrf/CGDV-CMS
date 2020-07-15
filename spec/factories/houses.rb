# == Schema Information
#
# Table name: houses
#
#  id               :integer          not null, primary key
#  habitaciones     :integer
#  tipo             :string(255)
#  habitantes       :integer
#  familiares       :integer
#  menores          :integer
#  economicaactivas :integer
#  patient_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :house do
    economicaactivas { 2 }
    familiares { 5 }
    habitaciones { 3 }
    habitantes { 3 }
    menores { 2 }
    tipo { "rentada" }
    patient_id { 1 }
  end
end
