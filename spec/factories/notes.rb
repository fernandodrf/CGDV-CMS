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
