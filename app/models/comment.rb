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