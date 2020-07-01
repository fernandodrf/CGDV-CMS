# Factory to create a Patient with the minimum requirements
FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
    cgdvcode { rand(1..50000) }
    sex { "M" }
    blod { "NS" }
    birthdate { Faker::Date.birthday }
    status { 1 }
    
    trait :active do
      status { 1 }
    end
    trait :inactive do
      status { 2 }
    end
  end
end