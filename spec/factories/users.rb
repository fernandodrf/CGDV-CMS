FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length = 8, max_length = 128) }
    
    trait :admin do
      admin { true }
    end
    
    trait :normal do
      admin { false }
      # FIXME: Find a way to add roles in fixtures
    end
  end
end
