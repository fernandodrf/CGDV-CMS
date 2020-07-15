# == Schema Information
#
# Table name: emails
#
#  id             :integer          not null, primary key
#  email          :string(255)
#  emailable_id   :integer
#  emailable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  datos          :string(255)
#

FactoryBot.define do
  factory :email do
    email { "juan@papas.com" }
    emailable_id { 1 }
    emailable_type { "Patient" }
    datos { "su email emailador" }
  end
end
