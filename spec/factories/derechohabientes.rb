# == Schema Information
#
# Table name: derechohabientes
#
#  id         :integer          not null, primary key
#  seguro     :string(255)
#  afiliacion :string(255)
#  patient_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :derechohabiente do
    seguro { "SSGDF IMSS DIF" }
    afiliacion { "SSGDF: 1234567/89" }
    patient_id { 1 }
  end
end
