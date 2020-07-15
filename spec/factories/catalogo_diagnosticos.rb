# == Schema Information
#
# Table name: catalogo_diagnosticos
#
#  id          :integer          not null, primary key
#  diagnostico :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :catalogo_diagnostico do
    diagnostico { "Cualquier String super largo áéíóú !@$*" }
  end
end
