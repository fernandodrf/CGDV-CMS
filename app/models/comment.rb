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

class Comment < ActiveRecord::Base  
  belongs_to :commentable, :polymorphic => true
  
  validates :commentable_id, :presence => true
  validates :commentable_type, :presence => true  
  #Para contar que tenga minimo 1 y maximo 200 palabras
  validates :comment, :presence => true, :length => {
    :minimum   => 1,
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\w+/) }
  }
  
end
