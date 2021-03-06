# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string(128)      default(""), not null
#  admin                  :boolean          default(FALSE)
#  language               :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  roles                  :string(255)      default("--- []")
#  volunteer_id           :integer
#  avatar                 :string(255)
#

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
    volunteer_id { 1 }

    trait :admin do
      admin { true }
    end
    
    trait :normal do
      admin { false }
      # FIXME: Find a way to add roles in fixtures
    end
  end
end
