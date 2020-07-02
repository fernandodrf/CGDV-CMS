FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length = 8, max_length = 128) }
    
    trait :normal do
      admin { false }
    end
    trait :admin do
      admin { true }
    end
    
  end
end
