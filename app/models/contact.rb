# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  company    :string(255)
#  position   :string(255)
#  birth      :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ApplicationRecord
  ransack_allow_all!
  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  
  validates :name, :presence => true
  validates :company, :presence => true
  validates :position, :presence => true
  validates :birth, :presence => true
end
