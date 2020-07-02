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
