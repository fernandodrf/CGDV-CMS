class Note < ActiveRecord::Base
  before_save :check_status
  
  belongs_to :patient
  has_many :elements, :dependent => :destroy
  accepts_nested_attributes_for :elements, :allow_destroy => true
  has_many :attachments, :as => :attachable, :dependent => :destroy
  

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