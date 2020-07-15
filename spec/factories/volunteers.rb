# == Schema Information
#
# Table name: volunteers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  sex        :string(255)
#  blood      :string(255)
#  status     :integer          default(1)
#  birth      :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string(255)
#

FactoryBot.define do
  factory :volunteer do
    name { Faker::Name.name }
    cgdvcode { rand(1..50000) }
    sex { "M" }
    blood { "NS" }
    birth { Faker::Date.birthday }
    status { 1 }
    
    trait :vol do
      status { 2 }
    end
  end
end
