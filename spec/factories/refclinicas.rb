# == Schema Information
#
# Table name: refclinicas
#
#  id         :integer          not null, primary key
#  hospital   :string(255)
#  medico     :string(255)
#  referencia :date
#  aceptado   :string(255)
#  ayudas     :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :refclinica do
    hospital { "Centro Medico AMLOVER" }
    medico { "Doctor Poncharelo Sánchez" }
    referencia { "2010-02-23" }
    aceptado { "Chuchita la de Quimio" }
    ayudas { "Medicamentos y Quimio" }
    patient_id { 1 }
  end
end
