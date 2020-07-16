# == Schema Information
#
# Table name: emails
#
#  id             :integer          not null, primary key
#  email          :string(255)
#  emailable_id   :integer
#  emailable_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  datos          :string(255)
#

class Email < ApplicationRecord  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  belongs_to :emailable, :polymorphic => true

  validates :email, :presence => true, :format => { :with => email_regex }
  validates :emailable_id, :presence => true
  validates :emailable_type, :presence => true
end
