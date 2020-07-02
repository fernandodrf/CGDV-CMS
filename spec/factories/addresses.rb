FactoryBot.define do
  factory :address do
    place { "Tios" }
    country { 1 }
    domicilio { "Santiago Xacatlan de las Peras Secas #34" }
    estado { "Donde Retumba el Pedo de Mexico" }
    municipio { "Maxahuixitlan" }
    colonia { "Guerrero" }
    addresseable_id { 1 }
    addresseable_type { "Patient" }
    codigopostal { "00022255" }
  end
end
