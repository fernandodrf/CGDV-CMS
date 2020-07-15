# == Schema Information
#
# Table name: patients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sex        :string(255)
#  birthdate  :date
#  blod       :string(255)
#  status     :integer          default(1)
#  fdefuncion :date
#  faviso     :date
#  montocon   :string(255)
#

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
