# == Schema Information
#
# Table name: catalogo_countries
#
#  id      :integer          not null, primary key
#  country :string(255)
#

FactoryBot.define do
  factory :catalogo_country do
    country { "Islandia" }
  end
end
