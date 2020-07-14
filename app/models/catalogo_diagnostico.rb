class CatalogoDiagnostico < ActiveRecord::Base
	
  validates :diagnostico, :presence => true
  
end
