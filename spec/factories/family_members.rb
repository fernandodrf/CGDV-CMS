# == Schema Information
#
# Table name: family_members
#
#  id              :integer          not null, primary key
#  parentesco      :string(255)
#  nombre          :string(255)
#  edad            :integer
#  derechohabiente :string(255)
#  comentarios     :string(255)
#  patient_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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
