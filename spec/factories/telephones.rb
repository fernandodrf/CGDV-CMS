# == Schema Information
#
# Table name: telephones
#
#  id                 :integer          not null, primary key
#  place              :string(255)
#  number             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  telephoneable_id   :integer
#  telephoneable_type :string(255)
#

FactoryBot.define do
  factory :telephone do
    number { 1234567890 }
    factory :tel_casa do
      place { "casa" }
    end
    factory :tel_trabajo do
      place { "trabajo" }
    end
  end
end
