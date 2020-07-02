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
