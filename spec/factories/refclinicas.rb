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
