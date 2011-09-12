class Donor < ActiveRecord::Base
  attr_accessible :persona, :cgdvcode, :name, :rfc, :birth, :extradonors_attributes
  
  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  
  has_many :extradonors, :dependent => :destroy

  accepts_nested_attributes_for :extradonors, :allow_destroy => true

  validates :name, :presence => true
  validates :birth, :presence => true
  validates :persona, :presence => true
  validates :cgdvcode, :presence => true, :length => {:maximum => 20}, :numericality => true, :uniqueness => true
  validates :rfc, :presence => true 
  
  Persona = [['Fisica',1],['Moral',2]]
end

# == Schema Information
#
# Table name: donors
#
#  id         :integer         not null, primary key
#  cgdvcode   :integer
#  persona    :integer
#  name       :string(255)
#  rfc        :string(255)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#

