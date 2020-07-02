FactoryBot.define do
  factory :telephone do
    number { 1234567890 }
    factory :tel_casa do
      place { "casa" }
    end
    factory :tel_trabajo do
      place { "trabajo" }
    end
  end
end
