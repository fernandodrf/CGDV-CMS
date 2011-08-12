class Provider < ActiveRecord::Base
  attr_accessible :proveedor, :cgdvcode, :name
  
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

# == Schema Information
#
# Table name: providers
#
#  id         :integer         not null, primary key
#  proveedor  :string(255)
#  cgdvcode   :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

