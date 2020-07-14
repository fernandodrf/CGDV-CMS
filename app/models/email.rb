class Email < ActiveRecord::Base  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  belongs_to :emailable, :polymorphic => true

  validates :email, :presence => true, :format => { :with => email_regex }
  validates :emailable_id, :presence => true
  validates :emailable_type, :presence => true
end