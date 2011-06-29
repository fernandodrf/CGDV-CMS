# == Schema Information
# Schema version: 20110629195139
#
# Table name: catalogo_diagnosticos
#
#  id          :integer         not null, primary key
#  diagnostico :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class CatalogoDiagnostico < ActiveRecord::Base
	
  validates :diagnostico, :presence => true
  
end
