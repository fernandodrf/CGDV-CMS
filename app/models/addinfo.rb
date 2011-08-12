class Addinfo < ActiveRecord::Base
  attr_accessible :tipo, :info
  
  belongs_to :addinformation, :polymorphic => true

  validates :addinformation_id, :presence => true
  validates :addinformation_type, :presence => true  
  validates :tipo, :presence => true, :numericality => true
  validates :info, :presence => true
  
  ADDINFO = [['MSN Messenger',1],['Pagina Web',2],['Facebook',3],['Twitter',4],['Skype',5],['Nombre de Asistente', 6],['Otro',7],['R.F.C.',8]]
end


# == Schema Information
#
# Table name: addinfos
#
#  id                  :integer         not null, primary key
#  tipo                :integer
#  info                :string(255)
#  addinformation_id   :integer
#  addinformation_type :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

