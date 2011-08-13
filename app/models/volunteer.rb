class Volunteer < ActiveRecord::Base
  attr_accessible :name, :cgdvcode, :blood, :sex, :status, :birth

  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  
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
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

