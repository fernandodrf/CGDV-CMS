class Provider < ActiveRecord::Base
  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy  
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :name, :presence => true
  validates :proveedor, :presence => true
  validates :cgdvcode, :presence => true, 
            :length => { :maximum => 20},
            :numericality => true, 
            :uniqueness => true

end