# == Schema Information
# Schema version: 20110614033259
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
#

class Patient < ActiveRecord::Base
  attr_accessible :name, :cgdvcode, :sex, :blod, :birthdate
  
  has_many :patientphones, :dependent => :destroy
  has_many :addresses, :dependent => :destroy
  has_many :derechohabientes, :dependent => :destroy
  has_many :apoyos, :dependent => :destroy
  has_many :tratamientos, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  validates :name, :presence => true, 
            :length => { :maximum => 250}
  validates :cgdvcode, :presence => true,
  			:length => { :maximum => 20},
			:numericality => true, 
            :uniqueness => true
  validates :sex, :presence => true,
  			:length => { :maximum => 5}
  validates :blod, :presence => true,
    		:length => { :maximum => 5}
  validates :birthdate, :presence => true

  BLOODTYPES = ['NS', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
  
end
