class Note < ActiveRecord::Base
  attr_accessible :folio, :adeudo, :acuenta, :restan, :subtotal, :total, :fecha, :patient_id, :elements_attributes

  before_save :check_status
  
  belongs_to :patient
  has_many :elements, :dependent => :destroy
  accepts_nested_attributes_for :elements

  validates :patient_id, :presence => true
  validates :folio, :presence => true,:length => { :maximum => 20},
  			:numericality => true, :uniqueness => true
  validates :adeudo, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :acuenta, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :restan, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :subtotal, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :total, :presence => true, :length => { :maximum => 20}, :numericality => true
  validates :fecha, :presence => true
  
  protected
    def check_status
      @patient = Patient.find(patient_id) 
      if @patient.status != 1
      	errors[:patient_id] << I18n.t('note.error_pat')	
        false
      end
	end  
end


# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  folio      :integer
#  adeudo     :decimal(22, 2)
#  acuenta    :decimal(22, 2)
#  restan     :decimal(22, 2)
#  subtotal   :decimal(22, 2)
#  total      :decimal(22, 2)
#  fecha      :date
#  patient_id :integer
#  created_at :datetime
#  updated_at :datetime
#

