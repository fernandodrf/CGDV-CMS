class Contact < ActiveRecord::Base
  attr_accessible :name, :company, :position, :birth

  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates :name, :presence => true
  validates :company, :presence => true
  validates :position, :presence => true
  validates :birth, :presence => true
  
end

# == Schema Information
#
# Table name: contacts
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  company    :string(255)
#  position   :string(255)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#

