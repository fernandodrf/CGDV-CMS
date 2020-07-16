# == Schema Information
#
# Table name: catalogo_diagnosticos
#
#  id          :integer          not null, primary key
#  diagnostico :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CatalogoDiagnostico < ApplicationRecord
	
  validates :diagnostico, :presence => true
  
end
