class Volunteer < ActiveRecord::Base
  attr_accessible :name, :cgdvcode, :blood, :sex, :status, :birth, :extravolunteers_attributes, :socialservices_attributes

  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  has_many :extravolunteers, :dependent => :destroy
  has_many :socialservices, :dependent => :destroy
  has_one :subprogram, :dependent => :destroy  
  
  accepts_nested_attributes_for :extravolunteers, :allow_destroy => true
  accepts_nested_attributes_for :socialservices, :allow_destroy => true
  
  validates :name, :presence => true
  validates :status, :presence => true
  validates :cgdvcode, :presence => true, 
  			:length => { :maximum => 20},
			:numericality => true, 
            :uniqueness => true
  validates :sex, :presence => true, :length => { :maximum => 5}
  validates :blood, :presence => true, :length => { :maximum => 5}
  validates :birth, :presence => true

  BLOODTYPES = ['NS', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
  STATUS = [['Servicio Social',1],['Voluntario',2]]  
  
end


# == Schema Information
#
# Table name: volunteers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  sex        :string(255)
#  blood      :string(255)
#  status     :integer         default(1)
#  birth      :date
#  created_at :datetime
#  updated_at :datetime
#

