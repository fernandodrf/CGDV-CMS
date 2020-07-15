# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  comment          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string(255)
#

FactoryBot.define do
  factory :comment do
    comment { "Este es un comentario comentante" }
    commentable_id { 1 }
    commentable_type { "Patient" }
  end
end
