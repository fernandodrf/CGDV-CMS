# == Schema Information
#
# Table name: patients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cgdvcode   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sex        :string(255)
#  birthdate  :date
#  blod       :string(255)
#  status     :integer          default(1)
#  fdefuncion :date
#  faviso     :date
#  montocon   :string(255)
#

class Patient < ApplicationRecord
  BLOODTYPES = ['NS', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
  STATUS = [['Activo',1],['Abandono',2],['Reglamentaria',3],['Defuncion',4],['Remision',5],['Acceso Seguridad Social',6]]  
  
  has_many :telephones, :as => :telephoneable, :dependent => :destroy
  has_many :addresses, :as => :addresseable, :dependent => :destroy
  has_many :addinfos, :as => :addinformation, :dependent => :destroy
  has_many :emails, :as => :emailable, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :diagnosticos, :as => :diagnosticable, :dependent => :destroy
  
  has_many :attachments, :as => :attachable, :dependent => :destroy
    
  has_many :derechohabientes, :dependent => :destroy
  has_many :apoyos, :dependent => :destroy
  has_many :tratamientos, :dependent => :destroy

  has_many :family_members, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_one :refclinica, :dependent => :destroy
  has_one :house, :dependent => :destroy
  has_one :socioeco, :dependent => :destroy
  
  validates :name, :presence => true
  validates :cgdvcode, :presence => true, 
  			:length => { :maximum => 20},
			:numericality => true, 
            :uniqueness => true
  validates :sex, :presence => true, :length => { :maximum => 5}
  validates :blod, presence: true, length: { maximum: 5 }, inclusion: { :in => BLOODTYPES }
  validates :birthdate, :presence => true
  validates :status, :presence => true, :numericality => true

end
