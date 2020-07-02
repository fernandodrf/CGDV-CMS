FactoryBot.define do
  factory :family_member do
    parentesco { "Otr@s Familia Amig@" }
    nombre { "Pepe Pepas Pica Papas" }
    edad { 1 }
    derechohabiente { "Peje Seguridad Social No. 145-78/243.1" }
    comentarios { "Un mega hiper largo comentario para probar" }
    patient_id { 1 }
  end
end
