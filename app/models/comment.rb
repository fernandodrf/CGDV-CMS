class Comment < ActiveRecord::Base
  attr_accessible :comment
  
  belongs_to :commentable, :polymorphic => true
  
  validates :commentable_id, :presence => true
  validates :commentable_type, :presence => true  
  validates :comment, :presence => true
  
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer         not null, primary key
#  comment          :text
#  patient_id       :integer
#  created_at       :datetime
#  updated_at       :datetime
#  commentable_id   :integer
#  commentable_type :string(255)
#

