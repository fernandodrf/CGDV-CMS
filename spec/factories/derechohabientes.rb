FactoryBot.define do
  factory :derechohabiente do
    seguro { "SSGDF IMSS DIF" }
    afiliacion { "SSGDF: 1234567/89" }
    patient_id { 1 }
  end
end
