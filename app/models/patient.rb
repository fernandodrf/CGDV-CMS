class Patient < ActiveRecord::Base

  attr_accessible :name, :cgdvcode, :sex, :blod, :birthdate
  
  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :derechohabientes, :dependent => :destroy
  has_many :apoyos, :dependent => :destroy
  has_many :tratamientos, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :diagnosticos, :dependent => :destroy
  has_many :family_members, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_one :refclinica, :dependent => :destroy
  has_one :house, :dependent => :destroy
  has_one :socioeco, :dependent => :destroy
  
  validates :name, :presence => true, :length => { :maximum => 250}
  validates :cgdvcode, :presence => true, 
  			:length => { :maximum => 20},
			:numericality => true, 
            :uniqueness => true
  validates :sex, :presence => true, :length => { :maximum => 5}
  validates :blod, :presence => true, :length => { :maximum => 5}
  validates :birthdate, :presence => true

  BLOODTYPES = ['NS', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
  
end

# == Schema Information
#
# Table name: patients
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  created_at :datetime
#  updated_at :datetime
#  sex        :string(255)
#  birthdate  :date
#  blod       :string(255)
#  oldid      :string(255)
#

