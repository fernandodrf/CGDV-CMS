class Contact < ActiveRecord::Base
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