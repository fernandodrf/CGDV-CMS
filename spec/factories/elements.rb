# == Schema Information
#
# Table name: elements
#
#  id          :integer          not null, primary key
#  codigo      :string(255)
#  cantidad    :integer
#  cuota       :decimal(22, 2)
#  descripcion :string(255)
#  note_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :element do
    codigo { "123" }
    cantidad { 10 }
    cuota { "9.99" }
    descripcion { "Papas" }
    note_id { 1 }
  end
end
