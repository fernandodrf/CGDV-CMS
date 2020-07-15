# == Schema Information
#
# Table name: addinfos
#
#  id                  :integer          not null, primary key
#  tipo                :integer
#  info                :string(255)
#  addinformation_id   :integer
#  addinformation_type :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :addinfo do
    tipo { 3 }
    info { "Facebook" }
    addinformation_id { 1 }
    addinformation_type { "Patient" }
  end
end
