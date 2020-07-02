FactoryBot.define do
  factory :comment do
    comment { "Este es un comentario comentante" }
    commentable_id { 1 }
    commentable_type { "Patient" }
  end
end
