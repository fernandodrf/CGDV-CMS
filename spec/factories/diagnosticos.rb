# == Schema Information
#
# Table name: diagnosticos
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  diagnostico         :integer
#  diagnosticable_id   :integer
#  diagnosticable_type :string(255)
#

FactoryBot.define do
  factory :diagnostico do
    diagnostico { 10 }
    diagnosticable_id { 10 }
    diagnosticable_type { "Diagnostico diagnostiquero" }
  end
end
