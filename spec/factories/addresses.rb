# == Schema Information
#
# Table name: addresses
#
#  id                :integer          not null, primary key
#  place             :string(255)
#  estado            :string(255)
#  municipio         :string(255)
#  colonia           :string(255)
#  domicilio         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  addresseable_id   :integer
#  addresseable_type :string(255)
#  country           :integer          default(1)
#  codigopostal      :string(255)
#

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
