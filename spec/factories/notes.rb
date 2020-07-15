# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  folio      :integer
#  adeudo     :decimal(22, 2)
#  acuenta    :decimal(22, 2)
#  restan     :decimal(22, 2)
#  subtotal   :decimal(22, 2)
#  total      :decimal(22, 2)
#  fecha      :date
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :note do
    folio { rand(1..10000) }
    fecha { Faker::Date.birthday }
    acuenta { rand(1.0...100.0) }
    adeudo { rand(1.00..100.00) }
    restan { rand(1.00..100.00) }
    subtotal { rand(1.00..100.00) }
    total { rand(1.00..100.00) }
  end
end
