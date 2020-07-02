FactoryBot.define do
  factory :email do
    email { "juan@papas.com" }
    emailable_id { 1 }
    emailable_type { "Patient" }
    datos { "su email emailador" }
  end
end
