# == Schema Information
#
# Table name: catalogo_derechohabientes
#
#  id         :integer          not null, primary key
#  seguro     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :catalogo_derechohabiente do
    seguro { "Cualquier String 12@!&" }
  end
end
