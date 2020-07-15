# == Schema Information
#
# Table name: socioecos
#
#  id               :integer          not null, primary key
#  ingresos         :integer
#  gastos           :integer
#  televisiones     :integer
#  vehiculos        :integer
#  nivel            :string(255)
#  serviciosurbanos :string(255)
#  televisionpaga   :string(255)
#  sgmm             :string(255)
#  patient_id       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryBot.define do
  factory :socioeco do
    gastos { 10000 }
    ingresos { 8000 }
    nivel { "2" }
    serviciosurbanos { "Si" }
    sgmm { "Super seguro medico de AMLOVA LOVA" }
    televisiones { 2 }
    televisionpaga { "No" }
    vehiculos { 0 }
    patient_id { 1 }
  end
end
