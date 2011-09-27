class Comment < ActiveRecord::Base
  attr_accessible :comment
  
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


# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  comment          :text
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#

